/*
  #+TITLE: Networking configuration

  * Mandatory configuration

  * Optional configuration
    Change hostname to your liking
    Change user directory to your liking
*/
{ pkgs, config, ... }:

{
  networking = {
    hostName = "nano";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
        Network = {
          NameResolvingService = "systemd";
        };
      };
    };
    # Use systemd-networkd
    useNetworkd = true;
  };

  services = {
    # Custom DNS
    resolved = {
      enable = true;
      dnssec = "false";
      extraConfig = ''
        DNS=194.242.2.4#base.dns.mullvad.net 2a07:e340::4#base.dns.mullvad.net
        DNSOverTLS=yes
        Domains=~.
      '';
    };

    # enables basic Avahi services and mDNS name resolution for IPv4
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };
    };
  };
}
