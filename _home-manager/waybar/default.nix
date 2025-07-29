/*
  #+TITLE: Waybar
  #+FILETAGS: :sway:

  * Optional configuration
   All possible config settings:
   https://github.com/Alexays/Waybar/blob/master/resources/config
*/
{ pkgs, config, ... }:

{
  home.file =
    let
      ln = config.lib.file.mkOutOfStoreSymlink;
    in
    {
      ".config/waybar/style-base.css".source = ln ./style-base.css;
      ".config/waybar/style-dark.css".source = ln ./style-dark.css;
      ".config/waybar/style-light.css".source = ln ./style-light.css;
      ".config/waybar/config.jsonc".source = ln ./config.jsonc;
    };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };
}
