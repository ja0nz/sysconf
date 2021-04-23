{ lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [ use-package ];
  };
  services.emacs = { enable = true; };

  home.packages = with pkgs; [
    # Dictionaries
    aspell # Spell checker for many languages
    aspellDicts.en # Aspell dictionary for English
    aspellDicts.de # Aspell dictionary for German

    # Database for org-roam
    sqlite # A self-contained, serverless, zero-configuration SQL db engine
  ];

  /* config_packages.org -> ~/.doom.d/config.el & ~/.doom.d/packages.el
     init.el -> ~/.doom.d/init.el
     snippets -> ~/.doom.d/snippets
  */
  home.activation.initEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    emacs --batch --eval "(require 'org)" --eval '(progn
      (org-babel-tangle-file "${./config_packages.org}")
      (org-babel-tangle-file "${./init.org}")
      )'
  '';
}
