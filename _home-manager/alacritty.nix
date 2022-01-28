/* #+TITLE: Alacritty - a terminal emulater
   #+FILETAGS: :shell:ui:sway:

   * Mandatory configuration
    Alacritty needs a (monospace) font.
    You either pass the variable in your config or set manually.
    Run ~fc-list : family~ and choose a font family.
*/
{ config, ... }:

let fontfamily = config._monoFont.name; # TODO Pass in a font or set it manually
in {
  programs.alacritty = {
    enable = true;
    settings = {
      # TODO Left here for reference on how to assign custom behavior to alacritty. For the normal "open-URL-on-click" alacritty works just fine.
      # See docs: https://github.com/alacritty/alacritty/blob/2538c87d3e8f67c1a7c4ef634bcd09a0c77b9879/alacritty.yml#L458
      # hints = {
      #   enabled = [{
      #     regex = ''
      #       (ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001F\u007F-\u009F<>"\\s{-}\\^⟨⟩`]+'';
      #     command = "chromium";
      #     post_processing = true;
      #     mouse = { enabled = true; };
      #   }];
      # };
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
      window.opacity = 0.9;
    };
  };
}
