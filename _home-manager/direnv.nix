/* #+TITLE: Direnv - scoped environment variables
   #+FILETAGS: :development:
*/
{ ... }:

{
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableFishIntegration = true;
  };
}
