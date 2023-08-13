/* #+TITLE: Mopidy - An extensible music server
   #+FILETAGS: :music:service:

   * Optional configuration
    - YTMusic: https://github.com/OzymandiasTheGreat/mopidy-ytmusic
    - Soundcloud: https://github.com/mopidy/mopidy-soundcloud
*/
{ pkgs, ... }:

{
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd # ncmpcpp player
      mopidy-mpris # playerctl controls
      mopidy-ytmusic
      mopidy-somafm
      mopidy-soundcloud
    ];
    settings = {
      # Reauth YT:
      # goto: https://music.youtube.com
      # F12 -> Network -> any post request (like log_event) -> Request Headers
      # refresh values: cookie, x-goog-visitor-id
      ytmusic = { auth_json = "$XDG_CONFIG_DIR/mopidy/ytmusic.json"; };
      # Reauth SoundCloud:
      # goto: https://mopidy.com/ext/soundcloud/#authentication
      soundcloud = { auth_token = "3-35204-1397311-RauCxeZsPJuoSGVl4"; };
      mpd = { hostname = "::"; };
      somafm = {
        encoding = "aac";
        quality = "highest";
      };
    };
  };
  # A featureful ncurses based MPD client inspired by ncmpc
  programs.ncmpcpp.enable = true;
}
