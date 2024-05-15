{ pkgs, ... }:

{
  packages = with pkgs; [
    git
    sops # Mozilla sops (Secrets OPerationS) is an editor of encrypted files
    manix # A Fast Documentation Searcher for Nix
    niv # Easy dependency management for Nix projects
  ];

  pre-commit.hooks = {
    # format *.nix
    nixfmt.enable = true;
  };

  languages.nix.enable = true;
}
