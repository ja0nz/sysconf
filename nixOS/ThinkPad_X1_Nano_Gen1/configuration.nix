/*
  #+TITLE: ThinkPad X1 Nano Gen1

  * Mandatory configuration
    Set repoPath and configPath

  * Optional configuration
*/
{ pkgs, lib, ... }:

{

  imports =
    let
      shared = ../_shared;
    in
    [
      ./hardware-configuration.nix
      ./networking.nix
      (shared + /cache)
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
    _configInUse = ./.;
    _monoFont = {
      name = "JetBrainsMono Nerd Font";
      pkg = pkgs.nerd-fonts.jetbrains-mono;
    };
    _sansFont = {
      name = "Arimo Nerd Font";
      pkg = pkgs.nerd-fonts.arimo;
    };
    _serifFont = {
      name = "Tinos Nerd Font";
      pkg = pkgs.nerd-fonts.tinos;
    };
    _emojiFont = {
      name = "Noto Color Emoji";
      pkg = pkgs.noto-fonts-color-emoji;
    };

    environment.sessionVariables = {
      # see graphics👇
      LIBVA_DRIVER_NAME = "iHD";
    };

    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = false;
        package = pkgs.bluez; # pkgs.bluezFull;
      };
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
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
      logind = {
        settings.Login.HandleLidSwitch = "ignore";
      };
      udev.extraRules = ''
        # Udev laptop killswitch
        ACTION=="remove", SUBSYSTEM=="block", ENV{ID_SERIAL_SHORT}=="0116007138600721", RUN+="${pkgs.systemd}/bin/shutdown -h now"

        # TODO Battery saving rules - x < 70 && x > 65
        # Double check if /sys/class/power_supply/BAT0/<filename> exists!
        KERNEL=="BAT0", SUBSYSTEM=="power_supply", ATTR{charge_start_threshold}="65"
        KERNEL=="BAT0", SUBSYSTEM=="power_supply", ATTR{charge_control_start_threshold}="65"
        KERNEL=="BAT0", SUBSYSTEM=="power_supply", ATTR{charge_end_threshold}="70"
        KERNEL=="BAT0", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="70"
      '';
    };

    security = {
      # Swaylock - see sway/default.nix
      pam.services.swaylock = { };
      pam.services.hyprlock = { };
      pam.services.greetd.enableGnomeKeyring = true;
    };

    programs = {
      # Displays keys being pressed on a Wayland session
      # Good for demoing stuff
      # Requires SETUID
      wshowkeys.enable = true;
      fish.enable = true;
      dconf.enable = true;
    };

    #    services.gvfs.enable = true;
    #    programs.adb.enable = true;

    system.stateVersion = "21.05"; # Did you read the comment?
  };

  # Global options
  options = with lib; {
    _configInUse = mkOption { type = types.path; };
    _monoFont = mkOption { type = types.attrs; };
    _sansFont = mkOption { type = types.attrs; };
    _serifFont = mkOption { type = types.attrs; };
    _emojiFont = mkOption { type = types.attrs; };
  };
}
