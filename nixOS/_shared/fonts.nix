/* #+TITLE: Font Configuration
   Set up the fonts
*/
{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "symbola" ];

  fonts = {
    fonts = [
      config._monoFont.pkg
      config._sansFont.pkg
      config._serifFont.pkg
      pkgs.emacs-all-the-icons-fonts
      pkgs.symbola
      # nerdfonts
      # powerline-fonts
      # iosevka
      # fira-code
      # source-code-pro
    ];
    enableDefaultFonts = true;

    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      defaultFonts = {
        monospace = [ config._monoFont.name ];
        sansSerif = [ config._sansFont.name ];
        serif = [ config._serifFont.name ];
      };
    };
  };
}
