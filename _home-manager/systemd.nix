{ config, pkgs, lib, setEnvironment, ... }:

{
  systemd.user.services = {
    # waybar = {
    #   Unit = {
    #     Description = pkgs.waybar.meta.description;
    #     PartOf = [ "graphical-session.target" ];
    #   };
    #   Install = {
    #     WantedBy = [ "sway-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.waybar}/bin/waybar";
    #     RestartSec = 3;
    #     Restart = "always";
    #   };
    # };
    # mako = {
    #   Unit = {
    #     Description = pkgs.mako.meta.description;
    #     PartOf = [ "graphical-session.target" ];
    #   };
    #   Install = {
    #     WantedBy = [ "sway-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.mako}/bin/mako --default-timeout 10000";
    #     RestartSec = 3;
    #     Restart = "always";
    #   };
    # };
    emacs = {
      Unit = {
        Description = "Emacs text editor";
        Documentation = "man:emacs(1)";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        Type = "forking";
        ExecStart = "${pkgs.bash}/bin/bash -c 'source ${setEnvironment}; exec ${pkgs.emacs}/bin/emacs --daemon'";
        ExecStop = "${pkgs.emacs}/bin/emacsclient --eval \"(kill-emacs)\"";
        Restart = "always";
      };
    };
  };
}
