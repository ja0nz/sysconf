{ lib, config, ... }:

let
  inherit (config) _configInUse _repoRoot _monoFont;
  packagePath = _configInUse + /packages.nix;
in {
  imports = [ <home-manager/nixos> ];

  home-manager.users.me = { ... }: {

    imports = [ packagePath ];
    config = {

      inherit _repoRoot _monoFont;
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
    options = with lib; {
      _repoRoot = mkOption { type = types.path; };
      _monoFont = mkOption { type = types.attrs; };
      _secret = mkOption { type = types.path; };
    };
  };
}
