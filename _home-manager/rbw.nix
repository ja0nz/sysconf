/*
  #+TITLE: rbw - unofficial command line client for Bitwarden
  #+FILETAGS: :security:
*/
{ pkgs, ... }:

{
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://vault.peteler.family/";
      email = "hey@ja.nz";
      lock_timeout = 50000; # ~ 14 hours
      pinentry = pkgs.pinentry-gnome3;
    };
  };
}
