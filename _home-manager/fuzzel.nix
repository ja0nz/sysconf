/*
  #+TITLE: fuzzel - Wayland-native application launcher, similar to rofi’s drun mode
  #+FILETAGS: :UI:
*/
{
  config,
  pkgs,
  lib,
  ...
}:

let
  fontfamily = config._monoFont.name; # TODO Pass in a font or set it manually
  emojifont = config._emojiFont.name;
in
{
  # home.packages = with pkgs; [
  #   # TODO write some custum scripts
  #   # https://github.com/chmouel/raffi/blob/main/examples/raffi.yaml
  #   raffi # Fuzzel launcher based on yaml configuration
  # ];
  programs.fuzzel = {
    enable = true;
    settings = {
      # https://man.archlinux.org/man/fuzzel.ini.5.en
      main = {
        dpi-aware = "auto";
        font = "${fontfamily}:size=14, ${emojifont}:size=14";
        terminal = "footclient";
        width = "50";
        layer = "overlay";
        exit-on-keyboard-focus-loss = "no";
        inner-pad = "15";
        fields = "filename,name";
      };
      colors = {
        background = "#1c1c1cff";
        text = "#eceff1ff";
        match = "#d81b60ff";
        selection = "#e53935ff";
        selection-text = "#eceff1ff";
        border = "#e53935ff";
      };
      border = {
        width = 2;
        radius = 5;
      };
    };
  };
}
