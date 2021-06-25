/* #+TITLE: Direnv - scoped environment variables
   #+FILETAGS: :development:
*/
{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableFishIntegration = true;
  };
}
