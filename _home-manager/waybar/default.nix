/*
  #+TITLE: Waybar
  #+FILETAGS: :sway:

  * Optional configuration
   All possible config settings:
   https://github.com/Alexays/Waybar/blob/master/resources/config
*/
{ config, sources, ... }:

let
  flake = sources.Waybar;
  waybar = (import sources.flake-compat { src = flake; }).outputs;
in
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
    package = waybar.packages.${builtins.currentSystem}.waybar;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };
}
