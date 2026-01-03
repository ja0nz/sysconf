/*
  #+TITLE: Lsd - a modern replacement for ls
  #+FILETAGS: :navigation:

  Lsd aliases set by enableAliases:
     - ls = "${pkgs.lsd}/bin/lsd";
     - ll = "${pkgs.lsd}/bin/lsd -l";
     - la = "${pkgs.lsd}/bin/lsd -a";
     - lt = "${pkgs.lsd}/bin/lsd --tree";
     - lla = "${pkgs.lsd}/bin/lsd -la";
*/
{ ... }:

{
  programs.lsd = {
    enable = true;
    settings = {
      date = "relative";
      # The 'icons' block requires 'when' and 'theme'
      icons = {
        when = "auto";
        theme = "fancy";
      };
      # The 'sorting' block requires 'dir-grouping'
      sorting = {
        dir-grouping = "first";
      };
    };
  };
}
