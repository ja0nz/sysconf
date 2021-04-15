{ ... }:

{
  programs.emacs = {
    enable = true;
    # https://github.com/emacsmirror/epkgs
    extraPackages = epkgs: [ epkgs.use-package ];
  };
  services.emacs = { enable = true; };
}
