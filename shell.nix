{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nixfmt # An opinionated formatter for Nix
    manix # A Fast Documentation Searcher for Nix
    haskellPackages.update-nix-fetchgit # A program to update fetchgit values in Nix expressions
  ];
}
