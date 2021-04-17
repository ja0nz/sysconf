{ lib, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      use-package
    ];
  };
  services.emacs = { enable = true; };

  home.activation.initEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.emacs.d
    test -f ~/.emacs.d/init.el || emacs --batch --eval "(require 'org)" \
      --eval '(org-babel-tangle-file "${./init.el.org}")'
  '';
}
