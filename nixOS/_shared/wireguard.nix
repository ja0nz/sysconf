# #+TITLE: Stub: Just a small wireguard config
# This is basically a caputure all traffic configuration
{ ... }:
let
  wgProfiles = import ../../_secret/wg-profiles.nix;
  profile = wgProfiles.profile1;
  wgName = "wg0";
  v4 = profile.endpointV4;
  v6 = profile.endpointV6;
  fwMark = 34952;
  routeTable = 1000;
in
{
  environment.etc."wireguard/${wgName}-secret.key" = {
    text = profile.privateKey;
    mode = "0440";
    group = "systemd-network";
  };
  environment.etc."wireguard/${wgName}-psk.key" = {
    text = profile.presharedKey;
    mode = "0440";
    group = "systemd-network";
  };

  # networking
  systemd.network = {
    enable = true;
    netdevs."10-${wgName}" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "${wgName}";
      };
      wireguardConfig = {
        PrivateKeyFile = "/etc/wireguard/${wgName}-secret.key";
        FirewallMark = fwMark;
      };
      wireguardPeers = [
        {
          PublicKey = profile.publicKey;
          PresharedKeyFile = "/etc/wireguard/${wgName}-psk.key";
          Endpoint = "${if v6 != "" then v6 else v4}";
          AllowedIPs = [ "0.0.0.0/0" ];
          PersistentKeepalive = 25;
          RouteTable = routeTable;
        }
      ];
    };
    networks."10-${wgName}" = {
      matchConfig.Name = "${wgName}";
      address = [ profile.address ];
      # Using DoH anyway, don't care about DNS tunneling
      # dns = [ profile.endpointDNS ];
      # domains = [ "~." ];
      # networkConfig = {
      #   DNSDefaultRoute = true;
      # };
      routingPolicyRules = [
        {
          Family = "both";
          FirewallMark = fwMark;
          InvertRule = true;
          Table = routeTable;
          Priority = 10;
        }
        {
          To = "${builtins.head (builtins.split ":" (if v6 != "" then v6 else v4))}/32";
          Priority = 5;
        }
      ];
    };
  };

  # Switching off IPv4 or IPv6
  # Not sure if this is actually needed
  # but it does not do harm so far
  systemd.services."${wgName}-firewall" = {
    enable = false; # TODO set true if desired
    description = "Blocking unwanted traffic on IPv4 and IPv6";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig =
      let
        # Kill-switch rules: block all traffic on ipv6
        ipv4Rules =
          if v4 != "" then
            [
              "/run/current-system/sw/bin/ip6tables -A OUTPUT ! -o ${wgName} -j DROP"
              "/run/current-system/sw/bin/ip6tables -A INPUT  ! -i ${wgName} -j DROP"
              "/run/current-system/sw/bin/iptables -I OUTPUT ! -o ${wgName} -m mark ! --mark ${builtins.toString fwMark} -m addrtype ! --dst-type LOCAL -j REJECT"
            ]
          else
            [ ];

        # Kill-switch rules: block all traffic on ipv4
        ipv6Rules =
          if v6 != "" then
            [
              "/run/current-system/sw/bin/iptables -A OUTPUT ! -o ${wgName} -j DROP"
              "/run/current-system/sw/bin/iptables -A INPUT  ! -i ${wgName} -j DROP"
            ]
          else
            [ ];

        # Function to convert rules to "delete" versions
        deleteRule = rule: builtins.replaceStrings [ "-A" "-I" ] [ "-D" "-D" ] rule;
        allRules = ipv4Rules ++ ipv6Rules;
      in
      {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = allRules;
        ExecStop = map deleteRule allRules;
      };
  };

}
