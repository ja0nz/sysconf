/* #+TITLE: McFly - An upgraded ctrl-r for Bash, Fish, Zsh
   #+FILETAGS: :shell:
*/
{ ... }:

{
  programs.mcfly = {
    enable = true;
    enableFishIntegration = true;
    enableFuzzySearch = true;
    keyScheme = "vim";
  };
}
