/*
  #+TITLE: GTK - icons and theming
  #+FILETAGS: :ui:

  * Mandatory configuration
   To set a font you can either pass in the variable or set manually.
   Run ~fc-list : family~ and choose a font family.
*/
{ pkgs, config, ... }:

{
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 22;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    font = {
      name = config._monoFont.name;
      size = 10;
    };

    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme.override {
        boldPanelIcons = true;
        alternativeIcons = true;
      };
    };
    theme = {
      # package = pkgs.dracula-theme;
      # name = "Dracula"
      package = pkgs.ant-bloody-theme;
      name = "Ant-Bloody";
    };
  };
  home.sessionVariables = {
    XDG_ICON_DIR = "${pkgs.whitesur-icon-theme}/share/icons/WhiteSur";
  };
}
