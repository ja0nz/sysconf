/*
  #+TITLE: Niri - Tiling window manager based on wayland
  #+FILETAGS: :niri:
  !Attention! Using this sway module by home manager alone is not sufficient!
  Related discussion: https://github.com/NixOS/nixpkgs/pull/89019#issuecomment-634845631

  * Mandatory configuration
   - To make hyprlock work: security.pam.services.hyprlock = { };

  * Optional configuration / packages
   - brillo
   - fuzzel
   - foot
   - hyprlock
   - cliphist
   - swww
   - kanshi
*/
{ pkgs, sources, ... }:

let
  flake = sources.niri-flake;
  niri = (import sources.flake-compat { src = flake; }).outputs;
in
{
  imports = [
    niri.homeModules.niri
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];
  home.packages = with pkgs; [
    playerctl # Command-line utility for controlling media players that implement MPRIS
    wtype # xdotool type for wayland
    swww # Animated wallpaper daemon for wayland
    # seatd
    # jaq
  ];
}
