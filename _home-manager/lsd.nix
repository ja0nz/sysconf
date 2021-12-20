/* #+TITLE: Lsd - a modern replacement for ls
   #+FILETAGS: :navigation:

   Lsd aliases set by enableAliases:
      - ls = "${pkgs.exa}/bin/exa";
      - ll = "${pkgs.exa}/bin/exa -l";
      - la = "${pkgs.exa}/bin/exa -a";
      - lt = "${pkgs.exa}/bin/exa --tree";
      - lla = "${pkgs.exa}/bin/exa -la";
*/
{ ... }:

{
  programs.lsd = {
    enable = true;
    enableAliases = true;
    # TODO Settings
    # https://github.com/Peltoche/lsd#config-file-content
    settings = { date = "relative"; };
  };
}
