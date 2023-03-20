/* #+TITLE: Mako - a lightweigth wayland notification daemon
   #+FILETAGS: :ui:sway:
*/
{ ... }:

{
  services.mako = {
    enable = true;
    defaultTimeout = 10000;
  };
}
