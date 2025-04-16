/* #+TITLE: Kanshi - dynamc display configuration tool
   #+FILETAGS: :sway:

   * Mandatory configuration
    - Set your output profiles!
*/
{ lib, ... }:

let
  # ThinkPad X1 Nano
  tpX1 = {
    criteria = "eDP-1";
    mode = "2160x1350@59.744Hz";
    position = "0,0";
    scale = 1.398438;
  };
  # TODO Calculate right position: 2160 / 1.398438
  _posRight = lib.toInt (lib.substring 0 4 tpX1.mode) / tpX1.scale;
  lgHome = {
    criteria = "LG Electronics LG IPS FULLHD 0x01010101";
    mode = "1920x1080@60.000Hz";
    position = "${builtins.toString (builtins.ceil _posRight)},0";
    scale = 1.0;
  };
in {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [ tpX1 ];
      }
      {
        profile.name = "docked";
        profile.outputs = [ tpX1 lgHome ];
      }
    ];
  };
}
