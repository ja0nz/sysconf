/* #+TITLE: Waybar
   #+FILETAGS: :sway:

   * Optional configuration
    All possible config settings:
    https://github.com/Alexays/Waybar/blob/master/resources/config

    Some waybar areas expect certain programs. This is a nonbreaking issue.
    - duf -> disk utility
    - networkmanager -> launch network control
    - playerctl -> player control (for spotify, browser, ctc)
    - spotify -> the player itself
*/
{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "sway-session.target";
    };
    # style = builtins.readFile ./waybar.css;
    settings = [{
      layer = "bottom";
      position = "bottom";
      height = 25;
      modules-left = [
        "sway/mode"
        "sway/workspaces"
        "sway/language"
        "pulseaudio" # "wireplumber"
        "backlight"
        "custom/waybar-mpris"
        "sway/window"
      ];
      # modules-center = [ "sway/window" ];
      modules-right = [ "cpu" "disk" "network" "battery" "clock" "tray" ];
      modules = {
        tray = { spacing = 10; };
        clock = {
          format = "{:%a %d %b ⟡ W%V ⟡ %H:%M}";
          tooltip-format = "{:%Y-%m-%d ⟡ W%V ⟡ %H:%M}";
          format-alt = "{:%Y-%m-%d}";
          on-click-right =
            "${pkgs.xdg-utils}/bin/xdg-open https://calendar.google.com";
        };
        cpu = {
          format = "<b>CPU</b>: {usage}%";
          on-click-right = "${pkgs.foot}/bin/foot btm";
        };
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "" "" "" "" "" "" "" ];
          on-scroll-up = "${pkgs.brillo}/bin/brillo -A 0.5";
          on-scroll-down = "${pkgs.brillo}/bin/brillo -U 0.5";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          # RTL rendering - whyyyyy???
          format-charging = " %{capacity}";
          format-plugged = "ﮣ %{capacity}";
          # format-full = "";
          format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
        };
        network = {
          format-icons = {
            wifi = "";
            ethernet = "";
            disconnected = "睊";
          };
          format-wifi = "{essid} | {signalStrength}% {icon}";
          format-ethernet = "{ipaddr} {icon}";
          format-disconnected = "⚠ {icon}";
          tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          on-click-right =
            "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          max-length = 40;
        };
        pulseaudio = { # wireplumber = { format-icons = [ "奄" "奔" "墳" ];
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "ﱝ %0";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            speaker = "蓼";
            hdmi = "﴿";
            hifi = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "奄" "奔" "墳" ];
          };
          scroll-step = 1;
          on-click = "${../switch-audio-port} 2>/dev/null";
          on-click-middle =
            "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "sway/language" = {
          format = "🖮 {short} {variant}";
          on-click =
            "${pkgs.sway}/bin/swaymsg input type:keyboard xkb_switch_layout next";
        };
        "sway/window" = {
          max-length = 70;
          rewrite = {
            "(.*) - Chromium" = "🌎 $1";
            "(.*) – Doom Emacs" = "📝 $1";
          };
        };
        "custom/waybar-mpris" = {
          return-type = "json";
          exec = "${./playerctl-mpris} 2>/dev/null";
          on-click = "${pkgs.playerctl}/bin/playerctl previous";
          on-click-middle = "${pkgs.playerctl}/bin/playerctl play-pause";
          on-click-right = "${pkgs.playerctl}/bin/playerctl next";
          escape = true;
          max-length = 20;
        };
        disk = {
          format = "{used} ";
          on-click-right = "${pkgs.foot}/bin/foot -H duf";
        };
      };
    }];
  };
}
