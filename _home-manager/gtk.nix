/* Optional requires:
   - _monoFont! Test with: fc-list : family | grep <MonoFontName>
*/
{ pkgs, config, ... }:

{
  gtk = {
    enable = true;
    font.name = config._monoFont.name + " 10";
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      # package = pkgs.dracula-theme;
      # name = "Dracula"
      package = pkgs.ant-bloody-theme;
      name = "Ant-Bloody";
    };
  };
}
