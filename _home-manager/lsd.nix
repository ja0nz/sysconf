/* #+TITLE: Lsd - a modern replacement for ls
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
    enableFishIntegration = true;
    # TODO Settings
    # https://github.com/Peltoche/lsd#config-file-content
    settings = { date = "relative"; };
  };
}
