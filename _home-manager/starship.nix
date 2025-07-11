/*
  #+TITLE: Starship - extremely customizable prompt for any shell
  #+FILETAGS: :shell:
*/
{ ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      # add_newline = false;
      # format = lib.concatStrings [
      #   "$line_break"
      #   "$package"
      #   "$line_break"
      #   "$character"
      # ];
      # scan_timeout = 10;
      # character = {
      #   success_symbol = "➜";
      #   error_symbol = "➜";
      # };
    };
  };
}
