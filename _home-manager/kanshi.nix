/* #+TITLE: Kanshi - dynamc display configuration tool
   #+FILETAGS: :sway:

   * Mandatory configuration
    - Set your output profiles!
*/
{ ... }:

let
  thinkPadX1Nano = {
    criteria = "eDP-1";
    mode = "2160x1350@59.744Hz";
    position = "0,0";
    scale = 1.4;
  };
  lgHome = {
    criteria = "DP-4";
    mode = "1920x1080@60.000Hz";
    position = "1542,0"; # TODO 2160 / 1.4 -> neighbor scale value
    scale = 1.0;
  };
in {
  services.kanshi = {
    enable = true;
    profiles = {
      undocked.outputs = [ thinkPadX1Nano ];
      dockedHome.outputs = [ thinkPadX1Nano lgHome ];
    };
  };
}
