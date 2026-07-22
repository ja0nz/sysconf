let
  sources = import ../../npins/default.nix;
  pkgs = import sources.nixpkgs { };
  jail-nix = (import sources.flake-compat { src = sources.jail-nix; }).outputs;
  jail = jail-nix.lib.init pkgs;
in
pkgs.callPackage ./sandbox.nix { inherit jail; }
