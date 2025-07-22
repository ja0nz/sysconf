/*
  #+TITLE: Sway - Tiling window manager based on wayland
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
{
  lib,
  config,
  pkgs,
  ...
}:

let
  modifier = "Mod4";
  chrome-flags = [
    "--extension-mime-request-handling=always-prompt-for-install"
    "--scroll-tabs=never"
    "--force-punycode-hostnames"
    "--show-avatar-button=never"
    "--hide-crashed-bubble"
    # chrome://flags
    "--enable-features=''"
  ];
in
{

  # Packages
  home.packages = with pkgs; [
    fuzzel
    cliphist # Wayland clipboard manager
    swayr # a window-switcher & more for sway
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
    # TODO Resolve https://github.com/WillPower3309/swayfx/blob/master/meson.build#L39
    # package = pkgs.swayfx;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    extraSessionCommands = ''
      # Wayland stuff
      export NIXOS_OZONE_WL=1
      export MOZ_ENABLE_WAYLAND=1
      export QT_QPA_PLATFORM=wayland
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';

    config = {
      # left = "j";
      # right = "l";
      # defaultWorkspace = "workspace number 1";
      bars = [ ];
      seat = {
        "*" = {
          xcursor_theme = "capitaine-cursors 30";
        };
      };
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
      menu = "fuzzel";
      terminal = "footclient";
      #workspaceAutoBackAndForth = true;
      inherit modifier;
      keybindings = lib.mkOptionDefault {

        # Fix "Workspace 10"
        "${modifier}+0" = "kill";

        # VIM style -> MIDDlE ROW
        "${modifier}+h" = ''exec "swayr prev-window all-workspaces"'';
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Ctrl+h" = "focus output left";
        "${modifier}+Ctrl+Shift+h" = "move workspace to output left";

        "${modifier}+j" = "focus down";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+k" = "focus up";
        "${modifier}+Shift+k" = "move up";

        "${modifier}+l" = ''exec "swayr next-window all-workspaces"'';
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Ctrl+l" = "focus output right";
        "${modifier}+Ctrl+Shift+l" = "move workspace to output right";
        "${modifier}+f" = "fullscreen toggle";

        # BOTTOM ROW
        "${modifier}+space" = ''exec "swayr switch-window"'';
        "${modifier}+Ctrl+space" = ''exec "swayr switch-workspace-or-window"'';
        "${modifier}+tab" = ''exec "swayr switch-to-urgent-or-lru-window"'';
        "${modifier}+Ctrl+tab" = "workspace back_and_forth";

        # Other sway -> TOP ROW
        "${modifier}+p" = ''exec "cliphist list | wofi -S dmenu | cliphist decode | wl-copy"'';
        #"${modifier}+u" = ''exec "papersway-msg cols incr"'';
        #"${modifier}+Ctrl+u" = ''exec "papersway-msg cols decr"'';
        #"${modifier}+i" = ''exec "papersway-msg absorb_expel left"'';
        #"${modifier}+Shift+i" = ''exec "papersway-msg absorb_expel right"'';

        #"${modifier}+o" = ''exec "papersway-msg fresh-workspace take"'';
        #"${modifier}+Ctrl+o" = ''exec "papersway-msg fresh-workspace send"'';

        "${modifier}+z" = "exec ${./swaylock}";
        "${modifier}+Ctrl+z" = ''exec "${./swaylock} && systemctl suspend"'';
        "${modifier}+q" = "kill";

        # Player -> BOTTOM ROW
        "${modifier}+m" = ''exec "playerctl position 3-"'';
        "${modifier}+Ctrl+m" = ''exec "playerctl previous"'';
        "${modifier}+comma" = ''exec "playerctl play-pause"'';
        "${modifier}+Ctrl+period" = ''exec "playerctl next"'';
        "${modifier}+period" = ''exec "playerctl position 3+"'';

        # Launcher
        "${modifier}+a" = ''exec "emacsclient -c"'';
        "${modifier}+s" = "exec chromium ${lib.concatStringsSep " " chrome-flags}";
        #"${modifier}+d" = "exec wldash"; -> by system
        "${modifier}+Ctrl+d" = "exec nemo";

        "Print" = "exec ${./take_screenshot}";
        "Ctrl+Print" = "exec ${./take_screenshot} full";

        # Pulseaudio switchers
        # "XF86AudioMute" = ''exec "pamixer --toggle-mute"'';
        # "XF86AudioLowerVolume" = ''exec "pamixer --decrease 5"'';
        # "XF86AudioRaiseVolume" = ''exec "pamixer --increase 5"'';
        # "XF86AudioMicMute" = ''exec "pamixer --default-source --toggle-mute"'';
        ## Wireplumber switchers
        "XF86AudioMute" = ''exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"'';
        "XF86AudioLowerVolume" = ''exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"'';
        "XF86AudioRaiseVolume" = ''exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"'';
        "XF86AudioMicMute" = ''exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"'';

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

        "XF86NotificationCenter" = ''exec "wofi-emoji"'';
        "XF86Go" = "exec ${../switch-audio-port} 2>/dev/null";
        "Cancel" = ''exec "swaymsg input type:keyboard xkb_switch_layout next"'';
        "XF86Favorites" =
          ''exec "emacsclient --eval '(save-some-buffers t)' 2>/dev/null; systemctl poweroff"'';
      };
      window = {
        border = 2;
        titlebar = false;
      };

      startup = [
        { command = "${pkgs.maestral}/bin/maestral start"; }
        { command = "${pkgs.autotiling}/bin/autotiling"; }
        {
          command = "${pkgs.swayr}/bin/swayrd";
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
          xkb_layout = "de";
          xkb_variant = "neo_qwertz";
        };
      };
      # TODO Set your input/output devices
      # swaymsg -t get_outputs
      output = {
        "*" = {
          bg = ''"${./background-image-secondary.png}" fill'';
        };
        "eDP-1" = {
          bg = ''"${./background-image-primary.png}" fill'';
        };
      };
    };
  };
}
