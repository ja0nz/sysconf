/* #+TITLE: Waybar
   #+FILETAGS: :sway:

   * Optional configuration
    Some waybar areas expect certain programs. This is a nonbreaking issue.
    - pavucontrol -> launch pulseaudio control
    - networkmanager -> launch network control
    - brave browser -> launch google calendar
    - pamixer -> mute audio
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
          on-click = "pamixer --toggle-mute";
          on-click-right = "pavucontrol";
        };
        "sway/window" = { max-length = 70; };
        "sway/mode" = {
          format = "{}";
          max-length = 50;
        };
        "custom/waybar-mpris" = let
          fmpris = ''
            {"class":"{{ status }}", "alt":"{{ status }}", "text":"{{ emoji(status) }} {{ artist }} - {{ title }}", "tooltip":"{{ markup_escape(artist) }} - {{ markup_escape(title) }}\n({{ playerName }})"}'';
        in {
          return-type = "json";
          exec = "${./playerctl.sh} 2> /dev/null";
          on-click = "playerctl previous";
          on-click-middle = "playerctl play-pause";
          on-click-right = "playerctl next";
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
