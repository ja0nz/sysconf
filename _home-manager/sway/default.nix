/* #+TITLE: Sway - Tiling window manager based on wayland
   #+FILETAGS: :sway:
   !Attention! Using this sway module by home manager alone is not sufficient!
   Related discussion: https://github.com/NixOS/nixpkgs/pull/89019#issuecomment-634845631

   * Mandatory configuration
    - Set your input/output devices!
    - To make swaylock work: security.pam.services.swaylock = { };

   * Optional configuration / packages (not imported here)
    - brillo -> as key combination
    - nemo -> as key combination
    - chromium browser -> as key combination
    - networkmanager_dmenu -> as key combination
    - wofi && wofi-emoji -> as key combination
    - dropbox -> as service on start
    - emacs -> as key combination
    - playerctl -> as key combination
    - _monoFont! Test with: fc-list : family | grep <MonoFontName>
*/
{ lib, config, pkgs, ... }:

let
  modifier = "Mod4";
  chrome-flags = [
    "--extension-mime-request-handling=always-prompt-for-install"
    "--scroll-tabs=never"
    "--force-punycode-hostnames"
    "--show-avatar-button=never"
    "--hide-crashed-bubble"
    "--hide-sidepanel-button"
    # chrome://flags
    "--enable-features='EnableTabMuting,WebRTCPipeWireCapturer'"
  ];
in {

  # Symlink mine keyboard layout
  # home.file.".xkb/symbols/mine".source = "${./mine}";

  # Packages
  home.packages = with pkgs; [
    wldash
    autotiling # Script for sway and i3 to automatically switch the horizontal / vertical window split orientation
    kanshi # Dynamic display configuration tool
    wl-clipboard # Command-line copy/paste utilities for Wayland
    grim # Grab images from a Wayland compositor
    jq # A lightweight and flexible command-line JSON processor
    slurp # Select a region in a Wayland compositor
    swaylock-effects # Screen locker for wayland
    swaybg # Wallpaper tool for Wayland compositors
    hicolor-icon-theme # Default fallback theme used by implementations of the icon theme specification
    capitaine-cursors # An x-cursor theme inspired by macOS and based on KDE Breeze

    # Notifications
    libnotify # A library that sends desktop notifications to a notification daemon
    libappindicator # A library to allow applications to export a menu into the Unity Menu bar
  ];

  wayland.windowManager.sway = {
    enable = true;
    systemd = { enable = true; };
    extraSessionCommands = ''
      # Wayland stuff
      export NIXOS_OZONE_WL=1
      export MOZ_ENABLE_WAYLAND=1
      export QT_QPA_PLATFORM=wayland
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1

      # Enable Anki wayland as of 03.02.2023
      export ANKI_WAYLAND=1

      # NOTE Importing of the full inherited environment block is deprecated.
      # dbus-update-activation-environment --systemd --all
      systemctl --user import-environment PATH
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
      terminal = "footclient";
      #workspaceAutoBackAndForth = true;
      inherit modifier;
      keybindings = lib.mkOptionDefault {

        # Mover -> MIDDLE ROW
        "${modifier}+n" = "focus left";
        "${modifier}+Ctrl+n" = "focus output left";
        "${modifier}+Shift+n" = "move left";
        "${modifier}+Ctrl+Shift+n" = "move workspace to output left";

        "${modifier}+t" = "focus right";
        "${modifier}+Ctrl+t" = "focus output right";
        "${modifier}+Shift+t" = "move right";
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
        "${modifier}+m" = ''exec "playerctl position 3-"'';
        "${modifier}+Ctrl+m" = ''exec "playerctl previous"'';
        "${modifier}+comma" = ''exec "playerctl play-pause"'';
        "${modifier}+Ctrl+period" = ''exec "playerctl next"'';
        "${modifier}+period" = ''exec "playerctl position 3+"'';

        # Launcher
        "${modifier}+x" = ''exec "emacsclient -c"'';
        "${modifier}+v" =
          "exec chromium ${lib.concatStringsSep " " chrome-flags}";
        "${modifier}+l" = "exec nemo";
        #"${modifier}+d" = "exec wldash"; -> by system
        "${modifier}+Ctrl+d" = "exec networkmanager_dmenu";

        "Print" = "exec ${./take_screenshot}";
        "Ctrl+Print" = "exec ${./take_screenshot} full";

        # Pulseaudio switchers
        # "XF86AudioMute" = ''exec "pamixer --toggle-mute"'';
        # "XF86AudioLowerVolume" = ''exec "pamixer --decrease 5"'';
        # "XF86AudioRaiseVolume" = ''exec "pamixer --increase 5"'';
        # "XF86AudioMicMute" = ''exec "pamixer --default-source --toggle-mute"'';
        ## Wireplumber switchers
        "XF86AudioMute" = ''exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"'';
        "XF86AudioLowerVolume" =
          ''exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"'';
        "XF86AudioRaiseVolume" =
          ''exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"'';
        "XF86AudioMicMute" =
          ''exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"'';

        # "XF86AudioPlay" = ''exec "playerctl play"'';
        # "XF86AudioPause" = ''exec "playerctl pause"'';
        # "XF86AudioNext" = ''exec "playerctl next"'';
        # "XF86AudioPrev" = ''exec "playerctl previous"'';

        "XF86MonBrightnessDown" = ''exec "brillo -U 1"'';
        "XF86MonBrightnessUp" = ''exec "brillo -A 1"'';
        "XF86Display" = ''exec "swaymsg 'output DP-4 toggle'"'';
        "XF86WLAN" = ''
          exec "nmcli networking connectivity | \
                    grep -q none && nmcli networking on || nmcli networking off"'';

        "XF86Messenger" = ''exec "wofi-emoji"'';
        "XF86Go" = "exec ${../switch-audio-port} 2>/dev/null";
        "Cancel" =
          ''exec "swaymsg input type:keyboard xkb_switch_layout next"'';
        "XF86Favorites" = ''
          exec "emacsclient --eval '(save-some-buffers t)' 2>/dev/null; systemctl poweroff"'';
      };
      window = {
        border = 2;
        titlebar = false;
      };

      startup = [
        {
          command = "${pkgs.dropbox-cli}/bin/dropbox start";
          always = true;
        }
        {
          command = "${pkgs.autotiling}/bin/autotiling";
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
        "type:keyboard" = {
          xkb_layout = "de,de";
          xkb_variant = "neo,";
        };
      };
      # TODO Set your input/output devices
      # swaymsg -t get_outputs
      output = {
        "*" = { bg = ''"${./background-image-secondary.png}" fill''; };
        "eDP-1" = { bg = ''"${./background-image-primary.png}" fill''; };
      };
    };
  };
}
