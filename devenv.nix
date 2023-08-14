{ pkgs, ... }:

{
  packages = with pkgs; [
    git
    sops # Mozilla sops (Secrets OPerationS) is an editor of encrypted files
    manix # A Fast Documentation Searcher for Nix
    update-nix-fetchgit # A program to update fetchgit values in Nix expressions
  ];

  pre-commit.hooks = {
    # format *.nix
    nixfmt.enable = true;
  };

  languages.nix.enable = true;
}
