{ pkgs, ... }:

{
  packages = with pkgs; [
    git
    sops # Mozilla sops (Secrets OPerationS) is an editor of encrypted files
    manix # A Fast Documentation Searcher for Nix
    npins # Simple and convenient dependency pinning for Nix
  ];

  git-hooks.hooks = {
    # format *.nix
    nixfmt-rfc-style.enable = true;
  };

  languages.nix.enable = true;
}
