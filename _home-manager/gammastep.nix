/* Optional requires:
   - geoclue2
*/
{ ... }:

{
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
  };
}
