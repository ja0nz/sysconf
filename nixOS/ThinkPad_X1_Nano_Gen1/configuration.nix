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

    hardware = {
      cpu.intel.updateMicrocode = true;
      #pulseaudio = {
      #  enable = true;
      #  extraModules = [ pkgs.pulseaudio-modules-bt ];
      #  package = pkgs.pulseaudioFull;
      #};
      bluetooth = {
        enable = true;
        package = pkgs.bluez; # pkgs.bluezFull;
      };
      opengl = {
        enable = true;
        extraPackages = with pkgs;
          [
            intel-media-driver # LIBVA_DRIVER_NAME=iHD
          ];
      };
      brillo.enable = true;
    };

    services = {
      upower.enable = true;
      fstrim.enable = true;
      #geoclue2.enable = true;
      blueman.enable = true;
      tlp.enable = true;
      logind.lidSwitch = "ignore";
      # Udev laptop killswitch
      udev.extraRules = ''
        ACTION=="remove", SUBSYSTEM=="block", ENV{ID_SERIAL_SHORT}=="0116007138600721", RUN+="${pkgs.systemd}/bin/shutdown -h now"
      '';
    };

    # Related to sway, no other way to set in home-manager!
    security.pam.services.swaylock = { };

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
