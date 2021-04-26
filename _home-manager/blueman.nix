/* #+TITLE: Blueman Bluetooth Applet
   #+FILETAGS: :ui:sway:

   * Mandatory configuration
      For the applet the 'blueman' service should be enabled system-wide.
      In NixOS: ~services.blueman.enable = true;~
*/
{ ... }:

{
  services.blueman-applet.enable = true;
}
