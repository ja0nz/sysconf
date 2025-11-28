let
  sources = import ../../npins;
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";
in
nixosSystem {
  system = null;
  specialArgs = { inherit sources; };
  modules = [
    ./configuration.nix
  ];
}
