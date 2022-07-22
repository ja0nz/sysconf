/* #+TITLE: XDG - base directory specification for X11/Wayland
   #+FILETAGS: :ui:

   * Optional configuration
    This mimeapps list is not crucial. It's just replicating the values
    set by the system. You may easily go without using this module.
*/
{ ... }:

{
  xdg.mime.enable = true;
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;
    associations = { added = { "image/png" = "pix.desktop"; }; };
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "text/html" = [ "chromium-browser.desktop" ];
      "x-scheme-handler/https" = [ "chromium-browser.desktop" ];
      "x-scheme-handler/http" = [ "chromium-browser.desktop" ];
      "image/png" = [ "pix.desktop " ];
      "image/jpeg" = [ "pix.desktop" ];
    };
  };
}
