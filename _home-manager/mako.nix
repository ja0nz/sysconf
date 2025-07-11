/*
  #+TITLE: Mako - a lightweigth wayland notification daemon
  #+FILETAGS: :ui:sway:
*/
{ ... }:

{
  services.mako = {
    enable = true;
    settings.default-timeout = 10000;
  };
}
