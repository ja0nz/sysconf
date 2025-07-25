/*
  #+TITLE: Systemd --user services
  #+FILETAGS: :user:

  Currently not use! But here for reference if needed:)
  Gather status of runnung user services:
  ~systemctl --user status~
*/
{
  config,
  pkgs,
  lib,
  setEnvironment,
  ...
}:

let
  # Match the default socket path for the Neovim version so neovide continues
  # to work without wrapping it.
  socketDir = "%t/nvim";
  socketPath = "${socketDir}/server";
in
{
  systemd.user.sockets.nvim = {
    Unit = {
      Description = pkgs.neovim.meta.description;
    };
    Socket = {
      ListenStream = socketPath;
      FileDescriptorName = "server";
      SocketMode = "0600";
      DirectoryMode = "0700";
      # This prevents the service from immediately starting again
      # after being stopped, due to the function
      # `server-force-stop' present in `kill-emacs-hook', which
      # calls `server-running-p', which opens the socket file.
      FlushPending = true;
    };
    Install = {
      WantedBy = [ "sockets.target" ];
      # Adding this Requires= dependency ensures that systemd
      # manages the socket file, in the case where the service is
      # started when the socket is stopped.
      # The socket unit is implicitly ordered before the service.
      RequiredBy = [ "nvim.service" ];
    };
  };
  systemd.user.services = {
    maestral = {
      Unit = {
        Description = pkgs.maestral.meta.description;
        After = [ "network-online.target" ];
      };

      Service = {
        ExecStart = "${pkgs.maestral}/bin/maestral start -f";
        ExecStop = "${pkgs.maestral}/bin/maestral stop";
        Restart = "on-failure";
        RestartSec = 5;
        Environment = "PYTHONUNBUFFERED=1";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
    polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = pkgs.polkit_gnome.meta.description;
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install.WantedBy = [ "graphical-session.target" ];

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    #   mako = {
    #     Unit = {
    #       Description = pkgs.mako.meta.description;
    #       PartOf = [ "graphical-session.target" ];
    #     };
    #     Install = { WantedBy = [ "sway-session.target" ]; };
    #     Service = {
    #       ExecStart = "${pkgs.mako}/bin/mako --default-timeout 10000";
    #       RestartSec = 3;
    #       Restart = "always";
    #     };
    #   };
    #   emacs = {
    #     Unit = {
    #       Description = "Emacs text editor";
    #       Documentation = "man:emacs(1)";
    #     };
    #     Install = { WantedBy = [ "default.target" ]; };
    #     Service = {
    #       Type = "forking";
    #       ExecStart =
    #         "${pkgs.bash}/bin/bash -c 'source ${setEnvironment}; exec ${pkgs.emacs}/bin/emacs --daemon'";
    #       ExecStop = ''${pkgs.emacs}/bin/emacsclient --eval "(kill-emacs)"'';
    #       Restart = "always";
    #     };
    #   };
  };
}
