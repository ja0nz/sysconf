/* Optional requires:
   - _monoFont! Test with: fc-list : family | grep <MonoFontName>
*/
{ pkgs, config, ... }:

{
  gtk = {
    enable = true;
    font.name = config._monoFont.name + " 10";
    iconTheme = {
      package = pkgs.moka-icon-theme;
      name = "Moka";
    };
    theme = {
      # package = pkgs.dracula-theme;
      # name = "Dracula"
      package = pkgs.ant-bloody-theme;
      name = "Ant-Bloody";
    };
  };
}
