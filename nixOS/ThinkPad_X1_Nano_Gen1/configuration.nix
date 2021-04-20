{ pkgs, lib, ... }:

with lib; {
  imports = [
    ./hardware-configuration.nix
    ../_shared/common.nix
    ../_shared/cachix.nix
  ];

  config = {

    #TODO: Set your values
    networking.hostName = "nixos_nano";
    _repoRoot = /home/me/sysconf;
    _configInUse = ../ThinkPad_X1_Nano_Gen1;
    _monoFont = {
      name = "JetBrains Mono";
      pkg = pkgs.jetbrains-mono;
    };
    _sansFont = {
      name = "Noto Sans";
      pkg = pkgs.noto-fonts;
    };
    _serifFont = {
      name = "DeJaVu Serif";
      pkg = pkgs.dejavu_fonts;
    };

    hardware = { cpu.intel.updateMicrocode = true; };

    services = {
      upower.enable = true;

      tlp.enable = true;
      logind.lidSwitch = "ignore";

      # Udev laptop killswitch
      udev.extraRules = ''
        ACTION=="remove", SUBSYSTEM=="block", ENV{ID_SERIAL_SHORT}=="0116007138600721", RUN+="${pkgs.systemd}/bin/shutdown -h now"
      '';
    };
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
