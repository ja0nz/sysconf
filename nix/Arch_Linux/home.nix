{ lib, ... }:

{
  imports = [ ./packages.nix ];
  config = {

    #TODO Set your repo path
    _repoRootStringPath = "~/sysconf";
    _static = ../../_static;
    _secret = ../../_secret;

    nixpkgs.config = {
      allowBroken = true;
      allowUnfree = true;
      allowUnsupportedSystem = true;
      oraclejdk.accept_license = true;
    };

    nixpkgs.overlays = builtins.attrValues (import ./overlays.nix);
    #_module.args.setEnvironment = config.system.build.setEnvironment;
    home.stateVersion = "21.05";

    # Enable fontconfig
    fonts.fontconfig.enable = true;

    # Let Home Manager install and manage itself.
    # Managed by channel update?
    # programs.home-manager.enable = true;
  };

  # Global options
  options = with lib; {
    _repoRootStringPath = mkOption { type = types.str; };
    _static = mkOption { type = types.path; };
    _secret = mkOption { type = types.path; };
  };
}
