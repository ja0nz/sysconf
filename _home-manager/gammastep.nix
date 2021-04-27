/* #+TITLE: Gammastep - adjust the screen color temperature
   #+FILETAGS: :ui:sway:

   * Mandatory configuration
    Geoclue2 must be enabled to retrieve the position which
    is used to calculate the screen temperature. Alternatively
    you can set it manually.

    Enable geoclue2:
    In NixOS: ~geoclue2.enable = true;~
*/
{ ... }:

{
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
  };
}
