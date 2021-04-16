{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nixfmt # An opinionated formatter for Nix
    manix # A Fast Documentation Searcher for Nix
  ];
}
