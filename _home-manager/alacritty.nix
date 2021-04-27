/* #+TITLE: Alacritty - a terminal emulater
   #+FILETAGS: :ui:sway:

   * Mandatory configuration
    Alacritty needs a (monospace) font.
    You either pass the variable in your config or set manually.
    Run ~fc-list : family~ and choose a font family.

   * Optional configuration
    Set your favourite browser as mouse launcher.
*/
{ config, ... }:

let fontfamily = config._monoFont.name; # TODO Pass in a font or set it manually
in {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = fontfamily;
          style = "Regular";
        };
        bold = {
          family = fontfamily;
          style = "Bold";
        };
        italic = {
          family = fontfamily;
          style = "Italic";
        };
        bold-italic = {
          family = fontfamily;
          style = "Bold Italic";
        };
        size = 11;
      };
      colors = {
        primary = {
          background = "#282a36";
          foreground = "#f8f8f2";
        };
        cursor = { cursor = "#81c1e4"; };
        selection = { background = "#ccccc7"; };
        normal = {
          black = "#000000";
          red = "#ff5555";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#caa9fa";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#bfbfbf";
        };
        bright = {
          black = "#575b70";
          red = "#ff6e67";
          green = "#5af78e";
          yellow = "#f4f99d";
          blue = "#caa9fa";
          magenta = "#ff92d0";
          cyan = "#9aedfe";
          white = "#e6e6e6";
        };
      };
      background_opacity = 0.9;
      mouse.url.launcher = "brave"; # TODO Set your browser
    };
  };
}
