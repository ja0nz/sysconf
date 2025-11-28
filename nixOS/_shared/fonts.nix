/*
  #+TITLE: Font Configuration
  Set up the fonts
*/
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Allow the unfree symbola font
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "symbola" ];

  fonts = {
    packages = [
      config._monoFont.pkg
      config._sansFont.pkg
      config._serifFont.pkg
      config._emojiFont.pkg
      pkgs.emacs-all-the-icons-fonts
      pkgs.symbola
      # nerdfonts
      # powerline-fonts
      # iosevka
      # fira-code
      # source-code-pro
    ];
    enableDefaultPackages = true;

    fontconfig = {
      enable = true;
      antialias = true; # At high resolution (> 200 DPI), antialiasing has no visible effect
      defaultFonts = {
        monospace = [ config._monoFont.name ];
        sansSerif = [ config._sansFont.name ];
        serif = [ config._serifFont.name ];
        emoji = [ config._emojiFont.name ];
      };
    };
  };
}
