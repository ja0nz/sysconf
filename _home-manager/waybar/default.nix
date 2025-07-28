/*
  #+TITLE: Waybar
  #+FILETAGS: :sway:

  * Optional configuration
   All possible config settings:
   https://github.com/Alexays/Waybar/blob/master/resources/config
*/
{ pkgs, ... }:

{
  home.file.".config/waybar/style-base.css".source = ./style-base.css;
  home.file.".config/waybar/style-dark.css".source = ./style-dark.css;
  home.file.".config/waybar/style-light.css".source = ./style-light.css;
  home.file.".config/waybar/config.jsonc".source = ./config.jsonc;

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };
}
