/* #+TITLE: Fzf - a command line fuzzy finder in Go
   #+FILETAGS: :find:

   * Mandatory configuration
    Ensure fd is installed
*/
{ ... }:

{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'head {}'" ];
    historyWidgetOptions = [ "--sort" "--exact" ];
  };
}
