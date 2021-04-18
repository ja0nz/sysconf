{ lib, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [ use-package ];
  };
  services.emacs = { enable = true; };

  /* Using Prelude Emacs with Org-Mode tangeling
     config.el.org builds towards ~/.emacs/personal/config.el
  */
  home.activation.initEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    emacs --batch --eval "(require 'org)" \
      --eval '(org-babel-tangle-file "${./config.el.org}")'
  '';
}
