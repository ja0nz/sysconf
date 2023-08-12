/* #+TITLE: Waybar
   #+FILETAGS: :sway:

   * Optional configuration
    All possible config settings:
    https://github.com/Alexays/Waybar/blob/master/resources/config
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
          format-icons = [ "󰽤" "󰽥" "󰽣" "󰽦" "󰽢" ];
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
          format-charging = "󰉁 %{capacity}";
          format-plugged = " %{capacity}";
          # format-full = "";
          format-icons = [ "" "" "" "" "" ];
        };
        network = {
          format-icons = {
            wifi = "";
            ethernet = "󰈀";
            disconnected = "󰌙";
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
          format-muted = "󰝟";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            speaker = "󰓃";
            hdmi = "󰡁";
            phone = "󰄜";
            car = "";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          scroll-step = 1;
          on-click = "${../switch-audio-port} 2>/dev/null";
          on-click-middle =
            "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "${pkgs.helvum}/bin/helvum";
        };
        "sway/language" = {
          min-length = 8;
          format = "{short} {variant} ";
          on-click =
            "${pkgs.sway}/bin/swaymsg input type:keyboard xkb_switch_layout 0";
          on-click-middle =
            "${pkgs.sway}/bin/swaymsg input type:keyboard xkb_switch_layout 1";
          on-click-right =
            "${pkgs.sway}/bin/swaymsg input type:keyboard xkb_switch_layout 2";
        };
        "sway/window" = {
          max-length = 90;
          rewrite = {
            "(.*) - Chromium" = "🌐 $1";
            "(.*) – Doom Emacs" = "📝 $1";
          };
        };
        "custom/waybar-mpris" = {
          return-type = "json";
          on-click = "${pkgs.playerctl}/bin/playerctl previous";
          on-click-middle = "${pkgs.playerctl}/bin/playerctl play-pause";
          on-click-right = "${pkgs.playerctl}/bin/playerctl next";
          format = "{icon} {}";
          format-icons = {
            "mopidy Playing" = "▶️📻";
            "mopidy Paused" = "⏸️📻";
            "chromium Playing" = "▶️🌐";
            "chromium Paused" = "⏸️🌐";
          };
          exec = ''
            ${pkgs.playerctl}/bin/playerctl -a metadata --format '{"text": "{{markup_escape(title)}}", "tooltip": "{{artist}} : {{markup_escape(title)}} - {{playerName}}", "alt": "{{playerName}} {{status}}", "class": "{{status}}"}' -F'';
          max-length = 30;
        };
        disk = {
          format = "{used} 󰋊";
          on-click-right = "${pkgs.foot}/bin/foot -H duf";
        };
      };
    }];
  };
}
