/*
  #+TITLE: Direnv - scoped environment variables
  #+FILETAGS: :shell:development:
*/
{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
