/* #+TITLE: ThinkPad X1 Nano Gen1

   * Mandatory configuration
     Set repoPath and configPath

   * Optional configuration
*/
{ pkgs, lib, ... }:

with lib; {

  imports = let shared = ../_shared;
  in [
    ./hardware-configuration.nix
    (shared + /cachix/cachix.nix)
    (shared + /boot.nix)
    (shared + /base.nix)
    (shared + /users.nix)
    (shared + /fonts.nix)
    (shared + /pipewire.nix)
    (shared + /localization.nix)
    (shared + /virtualization.nix)
  ];

  config = {
    # TODO Set your values
    # Consult: https://www.nerdfonts.com/font-downloads
    # nixpkgs: https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
    _repoRoot = /home/me/sysconf;
    _configInUse = ../ThinkPad_X1_Nano_Gen1;
    _monoFont = {
      name = "JetBrainsMono Nerd Font";
      pkg = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    };
    _sansFont = {
      name = "Arimo Nerd Font";
      pkg = pkgs.nerdfonts.override { fonts = [ "Arimo" ]; };
    };
    _serifFont = {
      name = "Tinos Nerd Font";
      pkg = pkgs.nerdfonts.override { fonts = [ "Tinos" ]; };
    };

    networking = {
      hostName = "nixos_nano";
      wireless.iwd.enable = true;
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };
    };

    environment.variables = {
      # see Opengl👇
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };

    # Sound
    # [09.12.2022]
    # TODO - Trouble with current kernel 5.15.81
    # nix --extra-experimental-features nix-command eval -f '<nixpkgs>' 'linuxPackages.kernel.version'
    boot.kernelPackages = pkgs.linuxPackages_latest;

    hardware = {
      cpu.intel.updateMicrocode = true;
      bluetooth = {
        enable = true;
        package = pkgs.bluez; # pkgs.bluezFull;
      };
      opengl = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          libvdpau-va-gl # VDPAU_DRIVER=va_gl
        ];
      };
      brillo.enable = true;
    };

    services = {
      udisks2.enable = true;
      upower.enable = true;
      fstrim.enable = true;
      #geoclue2.enable = true; <- Went with manual location settings, no need for a geo service
      blueman.enable = true;
      tlp.enable = true;
      logind.lidSwitch = "ignore";
      # Udev laptop killswitch
      udev.extraRules = ''
        ACTION=="remove", SUBSYSTEM=="block", ENV{ID_SERIAL_SHORT}=="0116007138600721", RUN+="${pkgs.systemd}/bin/shutdown -h now"

        # TODO Battery saving rules - x < 70 && x > 65
        # Double check if /sys/class/power_supply/BAT0/<filename> exists!
        KERNEL=="BAT0", SUBSYSTEM=="power_supply", ATTR{charge_start_threshold}="65"
        KERNEL=="BAT0", SUBSYSTEM=="power_supply", ATTR{charge_control_start_threshold}="65"
        KERNEL=="BAT0", SUBSYSTEM=="power_supply", ATTR{charge_end_threshold}="70"
        KERNEL=="BAT0", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="70"
      '';

      # Custom DNS
      resolved = {
        enable = true;
        dnssec = "false";
        extraConfig = ''
          DNS=45.90.28.0#ec7379.dns.nextdns.io
          DNS=2a07:a8c0::#ec7379.dns.nextdns.io
          DNS=45.90.30.0#ec7379.dns.nextdns.io
          DNS=2a07:a8c1::#ec7379.dns.nextdns.io
          DNSOverTLS=yes
        '';
      };
    };

    security = {
      # Swaylock - see sway/default.nix
      pam.services.swaylock = { };
      # sway
      polkit.enable = true;
    };

    programs = {
      # Displays keys being pressed on a Wayland session
      # Good for demoing stuff
      # Requires SETUID
      wshowkeys.enable = true;
      fish.enable = true;
    };

    #    services.gvfs.enable = true;
    #    programs.adb.enable = true;

    system.stateVersion = "21.05"; # Did you read the comment?
  };

  # Global options
  options = {
    _repoRoot = mkOption { type = types.path; };
    _configInUse = mkOption { type = types.path; };
    _monoFont = mkOption { type = types.attrs; };
    _sansFont = mkOption { type = types.attrs; };
    _serifFont = mkOption { type = types.attrs; };
  };
}
