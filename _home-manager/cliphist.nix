/*
  #+TITLE: Cliphist - a clipboard history “manager” for wayland
  #+FILETAGS: :navigation:
*/
{ ... }:

{
  services.cliphist = {
    enable = true;
    allowImages = true;
    systemdTargets = [
      "sway-session.target"
    ];
  };
}
