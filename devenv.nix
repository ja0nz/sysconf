{ pkgs, ... }:

{
  packages = with pkgs; [
    git
    git-secret # A bash-tool to store your private data inside a git repository
    manix # A Fast Documentation Searcher for Nix
    update-nix-fetchgit # A program to update fetchgit values in Nix expressions
  ];

  pre-commit.hooks = {
    # hide modified secrets
    git-secret-hide = {
      enable = true;
      name = "git-secret-hide";
      description = "hide modified secrets";
      entry = "${pkgs.git-secret}/bin/git-secret hide -m";
      pass_filenames = false;
    };

    # format *.nix
    nixfmt.enable = true;
  };

  languages.nix.enable = true;
}
