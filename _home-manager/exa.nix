/*
Exa aliases:
  - ls = "${pkgs.exa}/bin/exa";
  - ll = "${pkgs.exa}/bin/exa -l";
  - la = "${pkgs.exa}/bin/exa -a";
  - lt = "${pkgs.exa}/bin/exa --tree";
  - lla = "${pkgs.exa}/bin/exa -la";
*/
{ ... }:

{
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
}
