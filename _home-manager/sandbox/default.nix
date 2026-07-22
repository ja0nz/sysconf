{ pkgs, sources, ... }:

let
  jail-nix = (import sources.flake-compat { src = sources.jail-nix; }).outputs;
  jail = jail-nix.lib.init pkgs;
in
{
  home.packages = [
    (pkgs.callPackage ./sandbox.nix { inherit jail; })
  ];
}
