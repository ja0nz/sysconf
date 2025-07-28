/*
  #+TITLE: Mako - a lightweigth wayland notification daemon
  #+FILETAGS: :ui:sway:
*/
{ config, ... }:

let
  fontfamily = config._monoFont.name; # TODO Pass in a font or set it manually
  emojifont = config._emojiFont.name;
in
{
  services.mako = {
    enable = true;
    settings = {
      font = "${fontfamily}:size=12, ${emojifont}:size=12";

      # Geometry: width, height, margin (top, right, bottom, left)
      width = 400;
      height = 120;
      margin = 10;
      padding = 12;

      # Colors
      background-color = "#1c1c1cff";
      text-color = "#eceff1ff";
      border-color = "#e53935ff";

      # Border & Radius
      border-size = 2;
      border-radius = 5;

      # Icons
      icons = true;

      # Maximum visible notifications
      max-visible = 3;

      # Ignore DND (optional)
      ignore-timeout = false;

      default-timeout = 10000;
    };
  };
}
# Font
