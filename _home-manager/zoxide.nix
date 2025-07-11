/*
  #+TITLE: Zoxide - a fast cd command that learns your habits
  #+FILETAGS: :shell:
*/
{ ... }:

{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ]; # TODO May not work on Nushell / POSIX shells
  };
}
