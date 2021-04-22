{ lib, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [ use-package ];
  };
  services.emacs = { enable = true; };

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
