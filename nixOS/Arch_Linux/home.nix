{ lib, pkgs, ... }:

{
  imports = [ ./packages.nix ];
  config = {

    nixpkgs.config = {
      #allowBroken = true;
      allowUnfree = true;
      #allowUnsupportedSystem = true;
      #oraclejdk.accept_license = true;
    };

    nixpkgs.overlays = builtins.attrValues (import ./overlays.nix);
    #_module.args.setEnvironment = config.system.build.setEnvironment;
    home = {
      username = "me";
      homeDirectory = "/home/me";
      stateVersion = "21.11";
    };

    # Enable fontconfig
    fonts.fontconfig.enable = true;

    # Let Home Manager install and manage itself.
    # Managed by channel update?
    programs.home-manager.enable = true;
  };

}
