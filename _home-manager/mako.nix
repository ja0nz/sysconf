/* #+TITLE: Mako - a lightweigth wayland notification daemon
   #+FILETAGS: :ui:sway:
*/
{ ... }:

{
  programs.mako = {
    enable = true;
    defaultTimeout = 10000;
  };
}
