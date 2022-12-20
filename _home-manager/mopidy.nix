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
      mopidy-mpd # ncmpcpp player
      mopidy-mpris # playerctl controls
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
