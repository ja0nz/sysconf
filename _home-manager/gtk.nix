/*
  #+TITLE: GTK - icons and theming
  #+FILETAGS: :ui:

  * Mandatory configuration
   To set a font you can either pass in the variable or set manually.
   Run ~fc-list : family~ and choose a font family.
*/
{ pkgs, config, ... }:

{
  gtk = {
    enable = true;
    font = {
      name = config._monoFont.name;
      size = 10;
    };
    iconTheme = {
      package = pkgs.numix-icon-theme;
      name = "Numix";
    };
    theme = {
      # package = pkgs.dracula-theme;
      # name = "Dracula"
      package = pkgs.ant-bloody-theme;
      name = "Ant-Bloody";
    };
  };
}
