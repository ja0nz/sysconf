{ lib, ... }:

with lib;

{
  config = {

    #TODO Set your repo path
    _sysconfHomeStr = "~/sysconf";
    _static = ../../_static;
    _secret = ../../_secret;

    nixpkgs.config = {
      allowBroken = true;
      allowUnfree = true;
      allowUnsupportedSystem = true;
      oraclejdk.accept_license = true;
    };

    nixpkgs.overlays = builtins.attrValues (import ./overlays.nix);

    # Enable fontconfig
    fonts.fontconfig.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    #home.username = "me";
    #home.homeDirectory = "/home/me";
    home.stateVersion = "21.05";
  };

  # Home manager imports
  imports = map (pkg: ../../_home-manager + pkg) [
    /emacs.nix
    # -- GUI --
    /sway.nix
    /mako.nix
    /waybar.nix
    /gammastep.nix
    /alacritty.nix
    # -- Sensors --
    /blueman.nix
    /udiskie.nix
    # -- SHELL --
    /fish.nix
    /exa.nix
    /lorri.nix
    /direnv.nix
    # -- OPS --
    /emails.nix
    /git.nix
    /gtk.nix
    /gpg.nix
    /ssh.nix
    /zathura.nix
    #/systemd.nix
    /xdg.nix
  ] ++ [ ./packages.nix ];

  # Global options
  options = {
    _sysconfHomeStr = mkOption { type = types.str; };
    _static = mkOption { type = types.path; };
    _secret = mkOption { type = types.path; };
  };
}
