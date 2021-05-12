/* #+TITLE: Waybar
   #+FILETAGS: :sway:

   * Optional configuration
    Some waybar areas expect certain programs. This is a nonbreaking issue.
    - pavucontrol -> launch pulseaudio control
    - networkmanager -> launch network control
    - brave browser -> launch google calendar
    - playerctl -> player control (for spotify, brave browser, ctc)
    - spotify -> the player itself
*/
{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./waybar.css;
    settings = [{
      layer = "bottom";
      position = "bottom";
      height = 25;
      modules-left = [
        "sway/workspaces"
        "cpu"
        "backlight"
        "pulseaudio"
        "custom/waybar-mpris"
      ];
      modules-center = [ "sway/window" ];
      modules-right =
        [ "sway/mode" "network" "custom/root" "battery" "clock" "tray" ];
      modules = {
        tray = { spacing = 10; };
        clock = {
          format = "{:%a %d %b | %H:%M | W%V}";
          tooltip-format = "{:%Y-%m-%d | %H:%M | W%V}";
          format-alt = "{:%Y-%m-%d}";
          on-click-right = "brave calendar.google.com";
        };
        cpu = { format = "<b>CPU</b>: {usage}%"; };
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "" ];
          on-scroll-up = "brillo -A 0.5";
          on-scroll-down = "brillo -U 0.5";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        network = {
          format-wifi = "{essid} | {signalStrength}%";
          format-ethernet = "{ipaddr} 🔌";
          tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          on-click-right = "nm-connection-editor";
          format-disconnected = "Disconnected ⚠";
          max-length = 40;
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "🎙";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          scroll-step = 1;
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-right = "pavucontrol";
        };
        "sway/window" = { max-length = 70; };
        "sway/mode" = {
          format = "{}";
          max-length = 50;
        };
        # Waybar-mpris taken from
        # https://git.hrfee.pw/hrfee/waybar-mpris
        "custom/waybar-mpris" = {
          # format = "📻 {}";
          return-type = "json";
          exec = "${./waybar-mpris} --play ▶ --pause ⏸ --position --autofocus";
          on-click = "${./waybar-mpris} --send toggle";
          # This option will switch between players on right click.
          on-click-right = "${./waybar-mpris} --send player-next";
          ## The options below will switch the selected player on scroll
          #on-scroll-up = "waybar-mpris --send player-next";
          #on-scroll-down = "waybar-mpris --send player-prev";
          ## The options below will go to next/previous track on scroll
          #on-scroll-up = "waybar-mpris --send next";
          #on-scroll-down = "waybar-mpris --send prev";
          escape = true;
          max-length = 40;
        };
        "custom/root" = {
          format = "{} 🖴";
          interval = 60;
          exec = "df -h | gawk '$6 == \"/\" {print $3 \"/\" $2}'";
        };
      };
    }];
  };
}
