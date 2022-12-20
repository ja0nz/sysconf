/* #+TITLE: Mopidy - An extensible music server
   #+FILETAGS: :music:service:

   * Optional configuration
    - YTMusic: https://github.com/OzymandiasTheGreat/mopidy-ytmusic
*/
{ pkgs, ... }:

{
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-mpris
      mopidy-ytmusic
      mopidy-somafm
      # mopidy-soundcloud # TODO broken [01.01.2023]
    ];
    settings = {
      # Reauth:
      #  nix-shell -p mopidy mopidy-ytmusic
      #  cd .config/mopidy
      #  mopidy ytmusic reauth
      ytmusic = { auth_json = "$XDG_CONFIG_DIR/mopidy/ytmusic.json"; };
    };
  };
  home.packages = with pkgs; [
    ncmpcpp # A featureful ncurses based MPD client inspired by ncmpc
    mpd-mpris # An implementation of the MPRIS protocol for MPD
  ];
}
