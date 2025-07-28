/*
  #+TITLE: Gammastep/wlsunset - adjust the screen color temperature
  #+FILETAGS: :ui:sway:

  * Mandatory configuration
   ** Automatic geolocation (gammastep)
     Geoclue2 must be enabled to retrieve the position which
     is used to calculate the screen temperature.

     Enable geoclue2 in nixOS:
     ~geoclue2.enable = true;~

   ** Manual geolocation
     Alternatively you can set it manually.
*/
{ ... }:

{
  # services.gammastep = {
  #   enable = true;
  #   provider = "manual"; # "geoclue2"
  #   tray = true;
  #   # TODO Set your location
  #   latitude = 49.8;
  #   longitude = 9.9;
  # };
  services.wlsunset = {
    enable = true;
    # TODO Set your location
    latitude = "47.997";
    longitude = "7.853";
  };
}
