/* #+TITLE: Zoxide - a fast cd command that learns your habits
   #+FILETAGS: :shell:
*/
{ ... }:

{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ ];
  };
}
