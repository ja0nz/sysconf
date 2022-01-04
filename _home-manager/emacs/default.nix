/* #+TITLE: Emacs
   #+FILETAGS: :program:

   * Mandatory configuration
    Add emacs-overlay if needed. This is the fast, compiled emacs version

   * Optional configuration
    Add your config.el files or untangle them
*/
{ lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc; # TODO Req emacs-overlay (see overlays.nix)
    #package = pkgs.emacsPgtkGcc; # HOLD give Pkgt a bit to mature
    #extraPackages = epkgs: with epkgs; [ use-package ];
  };
  services.emacs = {
    enable = true;
    socketActivation.enable = true;
  };

  home.packages = with pkgs; [
    # Dictionaries
    aspell # Spell checker for many languages
    aspellDicts.en # Aspell dictionary for English
    aspellDicts.de # Aspell dictionary for German

    # Database for org-roam
    sqlite # A self-contained, serverless, zero-configuration SQL db engine

    # Needed by doom emacs
    html-tidy # A HTML validator and `tidier'

    # Artist Mode dependency
    figlet # Program for making large letters out of ordinary text

    # Org roam dependency
    clang # A C language family frontend for LLVM (wrapper script)
  ];

  /* config_packages.org -> ~/.doom.d/config.el & ~/.doom.d/packages.el
     init.el -> ~/.doom.d/init.el
  */
  home.activation.initEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    emacs --batch --eval "(require 'org)" --eval '(progn
      (org-babel-tangle-file "${./config_packages.org}")
      (org-babel-tangle-file "${./init.org}")
      )'
  '';
}
