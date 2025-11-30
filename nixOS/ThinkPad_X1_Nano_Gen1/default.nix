let
  sources = import ../../npins;
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";
  determinate = (import sources.flake-compat { src = sources.determinate; }).outputs;
in
nixosSystem {
  system = null;
  specialArgs = { inherit sources; };
  modules = [
    ./configuration.nix
    determinate.nixosModules.default
  ];
}
