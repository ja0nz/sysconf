{ ... }:

{
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;
    associations = { added = { "image/png" = "eom.desktop"; }; };
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "text/html" = [ "brave-browser.desktop" ];
      "image/png" = [ "eom.desktop " ];
      "image/jpeg" = [ "eom.desktop" ];
    };
  };
}
