/*
Attention:
Note, for the applet to work, the 'blueman' service should be enabled system-wide.
in NixOS: services.blueman.enable = true;
*/
{ ... }:

{
  services.blueman-applet.enable = true;
}
