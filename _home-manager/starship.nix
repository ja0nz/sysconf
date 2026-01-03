/*
  #+TITLE: Starship - extremely customizable prompt for any shell
  #+FILETAGS: :shell:
*/
{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false; # Keeps the terminal tight

      # This part makes the prompt "Character" turn purple when in a Nix Shell
      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state( \($name\))]($style) ";
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      # Disable the timeout warning if you are working on large disk arrays or slow networks
      scan_timeout = 30;
    };
  };
}
