/* #+TITLE: Gammastep - adjust the screen color temperature
   #+FILETAGS: :ui:sway:

   * Mandatory configuration
    ** Automatic geolocation
      Geoclue2 must be enabled to retrieve the position which
      is used to calculate the screen temperature.

      Enable geoclue2 in nixOS:
      ~geoclue2.enable = true;~

    ** Manual geolocation
      Alternatively you can set it manually.
*/
{ ... }:

{
  services.gammastep = {
    enable = true;
    provider = "manual"; # "geoclue2"
    # TODO Set your location
    latitude = 49.788357;
    longitude = 9.930146;
    tray = true;
  };
}
