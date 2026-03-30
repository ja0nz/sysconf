let
  sources = import ../../npins;
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";
  determinate = (import sources.flake-compat { src = sources.determinate; }).outputs;
  nix-index-db = (import sources.flake-compat { src = sources.nix-index-db; }).outputs;
in
nixosSystem {
  system = null;
  specialArgs = { inherit sources; };
  modules = [
    ./configuration.nix
    determinate.nixosModules.default
    nix-index-db.nixosModules.default
    { programs.nix-index-database.comma.enable = true; }
  ];
}
