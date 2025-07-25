{ pkgs, ... }:
{
  # needed for GNOME services outside of GNOME Desktop
  dbus.packages = with pkgs; [
    gcr
    gnome-settings-daemon
    libsecret
  ];
  services.gnome-keyring.enable = true;
  # gvfs.enable = true;
}
