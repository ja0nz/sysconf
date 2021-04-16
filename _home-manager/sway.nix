/* Optional requires:
   - brillo -> as key combination
   - caja -> as key combination
   - brave browser -> as key combination
   - dropbox -> as service on start
   - emacs -> as key combination
   - playerctl -> as key combination
   - Source Code Pro as font! Test with: fc-list : family | grep 'Source Code Pro'
*/
{ config, lib, pkgs, ... }:

let
  inherit (config) _static;
  modifier = "Mod4";
in {

  # Packages
  home.packages = with pkgs; [
    wldash
    wl-clipboard # Command-line copy/paste utilities for Wayland
    grim # Grab images from a Wayland compositor
    slurp # Select a region in a Wayland compositor
    swaylock-effects # Screen locker for wayland

    hicolor-icon-theme # Default fallback theme used by implementations of the icon theme specification

    # dmenu network selector
    dmenu # A generic, highly customizable, and efficient menu for the X Window System
    networkmanager_dmenu # Small script to manage NetworkManager connections with dmenu

    # Notifications
    libnotify # A library that sends desktop notifications to a notification daemon
    libappindicator # A library to allow applications to export a menu into the Unity Menu bar
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = {
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
      fonts = [ "Source Code Pro 9" ];
      gaps = {
        inner = 10;
        outer = -10;
        bottom = -6;
        smartBorders = "on";
      };
      menu = "wldash";
      terminal = "alacritty";
      workspaceAutoBackAndForth = true;
      inherit modifier;
      keybindings = let
        lockcmd = ''
          swaylock \
              -f \
              --screenshots \
              --clock \
              --indicator \
              --indicator-radius 150 \
              --indicator-thickness 7 \
              --effect-blur 7x5 \
              --effect-vignette 0.6:0.6 \
              --ring-color bb00cc \
              --key-hl-color 880033 \
              --line-color 00000000 \
              --inside-color 00000088 \
              --separator-color 00000000 \
              --grace 2 \
              --fade-in 0.2 '';
      in lib.mkOptionDefault {
        "${modifier}+Ctrl+t" = "exec caja";
        "${modifier}+Ctrl+r" = lib.mkForce "exec emacsclient -c";
        "${modifier}+Ctrl+n" = "exec brave";
        "${modifier}+p" = "exec ${_static + "/take_screenshot"}";
        "${modifier}+Shift+p" = "exec ${_static + "/take_screenshot"} full";
        "${modifier}+l" = ''exec "${lockcmd}"'';
        "XF86MonBrightnessUp" = ''exec "brillo -A 1"'';
        "XF86MonBrightnessDown" = ''exec "brillo -U 1"'';
        "XF86AudioMute" = ''exec "pactl set-sink-mute @DEFAULT_SINK@ toggle"'';
        "XF86AudioLowerVolume" =
          ''exec "pactl set-sink-volume @DEFAULT_SINK@ -5%"'';
        "XF86AudioRaiseVolume" =
          ''exec "pactl set-sink-volume @DEFAULT_SINK@ +5%"'';
        "XF86AudioPlay" = ''exec "playerctl play"'';
        "XF86AudioPause" = ''exec "playerctl pause"'';
        "XF86AudioNext" = ''exec "playerctl next"'';
        "XF86AudioPrev" = ''exec "playerctl previous"'';
        "${modifier}+Ctrl+d" = "exec networkmanager_dmenu";
        "${modifier}+Ctrl+g" = "exec reboot";
        "${modifier}+Ctrl+h" = ''exec "shutdown -h now"'';
        "${modifier}+Ctrl+f" = ''exec "${lockcmd} && systemctl suspend"'';
      };
      window = {
        border = 2;
        titlebar = false;
      };

      startup = [{
        command = "dropbox start";
        always = true;
      }];
      #TODO Set your input devices
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
      #TODO Set your input/output devices
      # swaymsg -t get_outputs
      output = {
        "*" = { bg = ''"${_static + "/background-image.png"}" fill''; };
        "eDP-1" = {
          pos = "0,0";
          scale = "1.4";
          res = "2160x1350";
        };
      };
    };
  };
}
