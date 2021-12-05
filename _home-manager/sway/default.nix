/* #+TITLE: Sway - Tiling window manager based on wayland
   #+FILETAGS: :sway:
   !Attention! Using this sway module by home manager alone is not sufficient!
   Related discussion: https://github.com/NixOS/nixpkgs/pull/89019#issuecomment-634845631

   * Mandatory configuration
    - Set your input/output devices!
    - To make swaylock work: security.pam.services.swaylock = { };

   * Optional configuration / packages (not imported here)
    - brillo -> as key combination
    - caja -> as key combination
    - chromium browser -> as key combination
    - networkmanager_dmenu -> as key combination
    - dropbox -> as service on start
    - emacs -> as key combination
    - pamixer -> as key combination
    - playerctl -> as key combination
    - _monoFont! Test with: fc-list : family | grep <MonoFontName>
*/
{ lib, config, pkgs, ... }:

let
  modifier = "Mod4";
  chrome-flags = [
    "--enable-features=UseOzonePlatform"
    "--ozone-platform=wayland"
    "--extension-mime-request-handling=always-prompt-for-install"
    "--scroll-tabs=never"
    "--hide-crashed-bubble"
  ];
in {

  # Packages
  home.packages = with pkgs; [
    wldash
    kanshi # Dynamic display configuration tool
    wl-clipboard # Command-line copy/paste utilities for Wayland
    grim # Grab images from a Wayland compositor
    jq # A lightweight and flexible command-line JSON processor
    slurp # Select a region in a Wayland compositor
    swaylock-effects # Screen locker for wayland
    pamixer # Pulseaudio command line mixer
    hicolor-icon-theme # Default fallback theme used by implementations of the icon theme specification
    capitaine-cursors # An x-cursor theme inspired by macOS and based on KDE Breeze

    # Notifications
    libnotify # A library that sends desktop notifications to a notification daemon
    libappindicator # A library to allow applications to export a menu into the Unity Menu bar
  ];

  wayland.windowManager.sway = {
    enable = true;
    #package = null;
    extraSessionCommands = ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
      systemctl --user import-environment
    '';

    config = {
      left = "n";
      right = "t";
      bars = [ ];
      seat = { "*" = { xcursor_theme = "capitaine-cursors 30"; }; };
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

        # Mover -> MIDDLE ROW
        "${modifier}+n" = "focus left";
        "${modifier}+Ctrl+n" = "move left";
        "${modifier}+Shift+n" = "focus output left";
        "${modifier}+Ctrl+Shift+n" = "move workspace to output left";

        "${modifier}+t" = "focus right";
        "${modifier}+Ctrl+t" = "move right";
        "${modifier}+Shift+t" = "focus output right";
        "${modifier}+Ctrl+Shift+t" = "move workspace to output right";

        # BOTTOM ROW
        "${modifier}+space" = "workspace back_and_forth";

        # Other sway -> TOP ROW
        "${modifier}+k" = "exec ${./swaylock}";
        "${modifier}+Ctrl+k" = ''exec "${./swaylock} && systemctl suspend"'';
        "${modifier}+h" = "layout toggle splith tabbed";
        "${modifier}+g" = "floating toggle";
        "${modifier}+q" = "kill";

        # Player -> BOTTOM ROW
        "${modifier}+m" = ''exec "playerctl previous"'';
        "${modifier}+comma" = ''exec "playerctl play-pause"'';
        "${modifier}+period" = ''exec "playerctl next"'';

        # Launcher
        "${modifier}+x" = ''exec "emacsclient -c"'';
        "${modifier}+v" =
          "exec chromium ${lib.concatStringsSep " " chrome-flags}";
        "${modifier}+l" = "exec caja";
        #"${modifier}+d" = "exec wldash"; -> by system
        "${modifier}+Ctrl+d" = "exec networkmanager_dmenu";

        "Print" = "exec ${./take_screenshot}";
        "Ctrl+Print" = "exec ${./take_screenshot} full";
        "XF86MonBrightnessUp" = ''exec "brillo -A 1"'';
        "XF86MonBrightnessDown" = ''exec "brillo -U 1"'';

        "XF86AudioMute" = ''exec "pamixer --toggle-mute"'';
        "XF86AudioLowerVolume" = ''exec "pamixer --decrease 5"'';
        "XF86AudioRaiseVolume" = ''exec "pamixer --increase 5"'';
        # "XF86AudioPlay" = ''exec "playerctl play"'';
        # "XF86AudioPause" = ''exec "playerctl pause"'';
        # "XF86AudioNext" = ''exec "playerctl next"'';
        # "XF86AudioPrev" = ''exec "playerctl previous"'';

        "XF86AudioMicMute" = ''exec "pamixer --default-source --toggle-mute"'';
        "XF86Display" = ''exec "swaymsg 'output DP-4 toggle'"'';
        "XF86WLAN" = ''
          exec "nmcli networking connectivity | \
                    grep -q none && nmcli networking on || nmcli networking off"'';
        "XF86Favorites" = ''
          exec "emacsclient --eval '(save-some-buffers t)' 2>/dev/null; shutdown -h now"'';
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
          bg = ''"${./background-image-primary.png}" fill'';
          # TODO Left following for future refercence:
          # I use kanshi meanwhile but without you may set the values here
          # pos = "0,0";
          # scale = "1.4";
          # res = "2160x1350";
        };
      };
    };
  };
}
