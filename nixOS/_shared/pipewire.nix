/* #+TITLE: Pipewire multimedia framework
   Replaces pulseaudio and enables screen sharing
*/
{ pkgs, ... }:

{
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true; # <- Only needed for waybar pulseaudio
    # alsa.support32Bit = true;
  };

  # For screen sharing in wayland
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
  };
}
