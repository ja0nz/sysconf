/* #+TITLE: Sway - Tiling window manager based on wayland
   #+FILETAGS: :sway:

   * Mandatory configuration
    Set your input/output devices!

   * Optional configuration / packages (not imported here)
      - brillo -> as key combination
      - caja -> as key combination
      - brave browser -> as key combination
      - networkmanager_dmenu -> as key combination
      - dropbox -> as service on start
      - emacs -> as key combination
      - playerctl -> as key combination
      - _monoFont! Test with: fc-list : family | grep <MonoFontName>
*/
{ lib, config, pkgs, ... }:

let modifier = "Mod4";
in {

  # Packages
  home.packages = with pkgs; [
    wldash
    wl-clipboard # Command-line copy/paste utilities for Wayland
    grim # Grab images from a Wayland compositor
    jq # A lightweight and flexible command-line JSON processor
    slurp # Select a region in a Wayland compositor
    swaylock-effects # Screen locker for wayland
    hicolor-icon-theme # Default fallback theme used by implementations of the icon theme specification

    # Notifications
    libnotify # A library that sends desktop notifications to a notification daemon
    libappindicator # A library to allow applications to export a menu into the Unity Menu bar
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = {
      left = "n";
      right = "t";
      bars = [ ];
      colors = {
        focused = {
          border = "#81c1e4";
          background = "#81c1e4";
          text = "#FFFFFF";
          indicator = "#2e9ef4";
          childBorder = "#81c1e4";
        };
        focusedInactive = {
          border = "#282a36";
          background = "#282a36";
          text = "#999999";
          indicator = "#484e50";
          childBorder = "#282a36";
        };
        unfocused = {
          border = "#282a36";
          background = "#282a36";
          text = "#999999";
          indicator = "#282a36";
          childBorder = "#282a36";
        };
        urgent = {
          border = "#FF0000";
          background = "#8C5665";
          text = "#FF0000";
          indicator = "#900000";
          childBorder = "#FF0000";
        };
      };
      fonts = {
        names = [ config._monoFont.name ];
        size = 9.0;
      };
      gaps = {
        inner = 10;
        outer = -10;
        bottom = -6;
        smartBorders = "on";
      };
      menu = "wldash";
      terminal = "alacritty";
      #workspaceAutoBackAndForth = true;
      inherit modifier;
      keybindings = lib.mkOptionDefault {
        "${modifier}+q" = "kill";
        "${modifier}+g" = "floating toggle";
        "${modifier}+space" = "workspace back_and_forth";
        "${modifier}+h" = "layout toggle splith tabbed";
        "${modifier}+Ctrl+d" = "exec networkmanager_dmenu";
        "${modifier}+Ctrl+n" = ''exec "emacsclient -c"'';
        "${modifier}+Ctrl+r" = "exec brave";
        "${modifier}+Ctrl+t" = "exec caja";
        "${modifier}+k" = "exec ${./swaylock}";
        "${modifier}+Ctrl+k" = ''exec "${./swaylock} && systemctl suspend"'';

        "${modifier}+b" = ''exec "playerctl play-pause"'';
        "${modifier}+Ctrl+b" = ''exec "playerctl stop"'';
        "${modifier}+m" = ''exec "playerctl next"'';
        "${modifier}+Ctrl+m" = ''exec "playerctl previous"'';

        "Print" = "exec ${./take_screenshot}";
        "Ctrl+Print" = "exec ${./take_screenshot} full";
        "XF86MonBrightnessUp" = ''exec "brillo -A 1"'';
        "XF86MonBrightnessDown" = ''exec "brillo -U 1"'';
        "XF86AudioMute" = ''exec "pactl set-sink-mute @DEFAULT_SINK@ toggle"'';
        "XF86AudioLowerVolume" =
          ''exec "pactl set-sink-volume @DEFAULT_SINK@ -5%"'';
        "XF86AudioRaiseVolume" =
          ''exec "pactl set-sink-volume @DEFAULT_SINK@ +5%"'';
        # "XF86AudioPlay" = ''exec "playerctl play"'';
        # "XF86AudioPause" = ''exec "playerctl pause"'';
        # "XF86AudioNext" = ''exec "playerctl next"'';
        # "XF86AudioPrev" = ''exec "playerctl previous"'';
        "XF86AudioMicMute" =
          ''exec "pactl set-source-mute @DEFAULT_SOURCE@ toggle"'';
        "XF86Display" = ''exec "swaymsg 'output DP-4 toggle'"'';
        "XF86WLAN" = ''
          exec "nmcli networking connectivity | \
                    grep -q none && nmcli networking on || nmcli networking off"'';
        "XF86Favorites" = ''exec "shutdown -h now"'';
      };
      window = {
        border = 2;
        titlebar = false;
      };

      startup = [
        {
          command = "dropbox start";
          always = true;
        }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
      ];
      # TODO Set your input devices
      # swaymsg -t get_inputs
      input = {
        "1267:12624:ELAN0670:00_04F3:3150_Touchpad" = {
          natural_scroll = "enabled";
        };
        "2652:1:Bluetooth_Mouse_4.0" = {
          accel_profile = "adaptive";
          pointer_accel = "-0.6";
        };
        "*" = {
          xkb_layout = "de,de";
          xkb_variant = "neo,";
          xkb_options = "grp:rctrl_rshift_toggle";
        };
      };
      # TODO Set your input/output devices
      # swaymsg -t get_outputs
      output = {
        "*" = { bg = ''"${./background-image-secondary.png}" fill''; };
        "eDP-1" = {
          pos = "0,0";
          scale = "1.4";
          res = "2160x1350";
          bg = ''"${./background-image-primary.png}" fill'';
        };
      };
    };
  };
}
