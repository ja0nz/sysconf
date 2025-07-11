/*
  #+TITLE: McFly - An upgraded ctrl-r for Bash, Fish, Zsh
  #+FILETAGS: :shell:

  TODO Currently, 01.01.2022, fzf-history-widget seems to be broken for fish.
  Ref: https://github.com/junegunn/fzf/issues/2526
*/
{ ... }:

{
  programs.mcfly = {
    enable = true;
    enableFishIntegration = true;
    fuzzySearchFactor = 2;
    keyScheme = "vim";
  };
}
