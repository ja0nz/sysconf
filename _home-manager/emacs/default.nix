/*
  #+TITLE: Emacs
  #+FILETAGS: :program:

  * Mandatory configuration

  * Optional configuration
   Add your config.el files or untangle them
*/
{
  lib,
  pkgs,
  sources,
  ...
}:

let
  flake = sources.emacs-overlay;
  emacs-community = (import sources.flake-compat { src = flake; }).outputs;
in
{
  programs.emacs = {
    enable = true;
    package = emacs-community.packages.${builtins.currentSystem}.emacs-git-pgtk;
    #extraPackages = epkgs: with epkgs; [ use-package ];
  };
  services.emacs = {
    enable = true;
    socketActivation.enable = true;
  };

  home.packages = with pkgs; [
    # Dictionaries
    hunspell # Spell checker for many languages

    hunspellDicts.en_US # dictionary for English
    hunspellDicts.de_DE # dictionary for German
    hunspellDicts.nl_NL # dictionary for Dutch
    hunspellDicts.it_IT # dictionary for Italian
    hunspellDicts.fr-moderne # dictionary for French
    #hunspellDicts.es_ES # dictionary for spanish

    # Database for org-roam
    sqlite # A self-contained, serverless, zero-configuration SQL db engine

    # Needed by doom emacs
    # html-tidy # A HTML validator and `tidier'

    # Artist Mode dependency
    # figlet # Program for making large letters out of ordinary text

    # Org roam dependency
    clang # A C language family frontend for LLVM (wrapper script)
  ];

  /*
    config_packages.org -> ~/.doom.d/config.el & ~/.doom.d/packages.el
    init.el -> ~/.doom.d/init.el
  */
  home.activation.initEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    emacs --batch --eval "(require 'org)" --eval '(progn
      (org-babel-tangle-file "${toString ./.}/config_packages.org")
      (org-babel-tangle-file "${toString ./.}/init.org")
      )'
  '';
}
