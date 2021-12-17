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
          format = "{:%a %d %b | W%V | %H:%M}";
          tooltip-format = "{:%Y-%m-%d | W%V | %H:%M}";
          format-alt = "{:%Y-%m-%d}";
          on-click-right = "xdg-open https://calendar.google.com";
        };
        cpu = {
          format = "<b>CPU</b>: {usage}%";
          on-click-right = "alacritty -e btm";
        };
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
          format-icons = {
            wifi = "";
            ethernet = "";
            disconnected = "睊";
          };
          format-wifi = "{essid} | {signalStrength}% {icon}";
          format-ethernet = "{ipaddr} {icon}";
          format-disconnected = "⚠ {icon}";
          tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          on-click-right = "nm-connection-editor";
          max-length = 40;
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "ﱝ %00";
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
          format = "{} ";
          interval = 60;
          exec = "df -h | gawk '$6 == \"/\" {print $3 \" | \" $2}'";
        };
      };
    }];
  };
}
