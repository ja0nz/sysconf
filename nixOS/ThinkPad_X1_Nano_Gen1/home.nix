{ lib, ... }:

with lib;

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.me = { ... }: {

    imports = [ ./packages.nix ];
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
      #_module.args.setEnvironment = config.system.build.setEnvironment;
      home.stateVersion = "21.05";
    };

    # Global options
    options = {
      _sysconfHomeStr = mkOption { type = types.str; };
      _static = mkOption { type = types.path; };
      _secret = mkOption { type = types.path; };
    };
  };
}
