/*
  #+TITLE: Foot - a wayland terminal emulater
  #+FILETAGS: :shell:ui:sway:

  * Mandatory configuration
   Foot needs a (monospace) font.
   You either pass the variable in your config or set manually.
   Run ~fc-list : family~ and choose a font family.
*/
{
  config,
  lib,
  pkgs,
  ...
}:

let
  fontfamily = config._monoFont.name; # TODO Pass in a font or set it manually
  emojifont = config._emojiFont.name;
in
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "${fontfamily}:size=12, ${emojifont}:size=12";
        selection-target = "clipboard";
        horizontal-letter-offset = 0;
        vertical-letter-offset = 0;
        pad = "15x6center";
      };
      desktop-notifications.command = "${lib.getExe pkgs.libnotify} -a \${app-id} -i \${app-id} \${title} \${body}";
      scrollback = {
        lines = 10000;
        multiplier = 3;
        indicator-position = "relative";
        indicator-format = "line";
      };
      url = {
        launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
      };
      cursor = {
        style = "beam";
        beam-thickness = "2";
      };
      tweak = {
        font-monospace-warn = "no";
        sixel = "yes";
      };
      colors = {
        alpha = 0.9;
        selection-background = "ccccc7";
        selection-foreground = "333338";
        background = "282a36";
        foreground = "f8f8f2";

        regular0 = "000000";
        regular1 = "ff5555";
        regular2 = "50fa7b";
        regular3 = "f1fa8c";
        regular4 = "caa9fa";
        regular5 = "ff79c6";
        regular6 = "8be9fd";
        regular7 = "bfbfbf";

        bright0 = "575b70";
        bright1 = "ff6e67";
        bright2 = "5af78e";
        bright3 = "f4f99d";
        bright4 = "caa9fa";
        bright5 = "ff92d0";
        bright6 = "9aedfe";
        bright7 = "e6e6e6";
      };
    };
  };
}
