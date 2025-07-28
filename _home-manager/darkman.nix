/*
  #+TITLE: Darkman - Framework for dark-mode and light-mode transitions on Linux desktop
  #+FILETAGS: :ui:
*/
{ pkgs, ... }:

{
  services.darkman = {
    enable = true;
    darkModeScripts = {
      gtk-theme = ''
        ${pkgs.dconf}/bin/dconf write \
            /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
      '';
    };
    lightModeScripts = {
      gtk-theme = ''
        ${pkgs.dconf}/bin/dconf write \
            /org/gnome/desktop/interface/color-scheme "'prefer-light'"
      '';
    };

    settings = {
      lat = "47.997";
      lng = "7.853";
      usegeoclue = false;
    };
  };
}
