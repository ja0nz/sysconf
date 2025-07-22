let
  sources = import ../../nix/sources.nix;
  nixpkgs = builtins.fetchTarball {
    url = sources.nixpkgs.url;
    sha256 = sources.nixpkgs.sha256;
  };
  nixosSystem = import "${nixpkgs}/nixos/lib/eval-config.nix";
in
nixosSystem {
  system = null;
  specialArgs = { inherit sources; };
  modules = [
    ./configuration.nix
  ];
}
