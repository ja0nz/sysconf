/*
  #+TITLE: Fzf - a command line fuzzy finder in Go
  #+FILETAGS: :find:

  * Mandatory configuration
   Ensure fd is installed
*/
{ ... }:

{
  programs.fzf = {
    enable = true;

    # Use fd for speed
    defaultCommand = "fd --type f";

    # ALT-C: Preview directories using lsd
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'lsd --tree --depth 2 {} | head -200'" ];

    # CTRL-T: Preview files using bat (syntax highlighting!)
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];

    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
  };
}
