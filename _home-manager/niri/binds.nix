{
  config,
  pkgs,
  ...
}:
{
  # Todo
  #
  # "${modifier}+p" = ''exec "cliphist list | wofi -S dmenu | cliphist decode | wl-copy"'';
  programs.niri.settings.binds =
    with config.lib.niri.actions;
    let
      modifier = "Mod";
      externalMonitor = "DP-3";
      playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
      dms-ipc = spawn "dms" "ipc";
    in
    {
      # Actionkeys
      # Captured by DankMaterialShell
      # "XF86AudioMute" = {
      #   action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      #   allow-when-locked = true;
      # };
      # "XF86AudioMicMute" = {
      #   action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
      #   allow-when-locked = true;
      # };
      # "XF86AudioRaiseVolume" = {
      #   action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
      #   allow-when-locked = true;
      # };
      # "XF86AudioLowerVolume" = {
      #   action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
      #   allow-when-locked = true;
      # };
      # "XF86MonBrightnessUp" = {
      #   action = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000" "-A" "4";
      #   allow-when-locked = true;
      # };
      # "XF86MonBrightnessDown" = {
      #   action = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000" "-U" "4";
      #   allow-when-locked = true;
      # };
      # "${modifier}+XF86AudioRaiseVolume" = {
      #   action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "5%+";
      #   allow-when-locked = true;
      # };
      # "${modifier}+XF86AudioLowerVolume" = {
      #   action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "5%-";
      #   allow-when-locked = true;
      # };
      "Mod+D" = {
        action = dms-ipc "spotlight" "toggle";
        hotkey-overlay.title = "Toggle Application Launcher";
      };
      "Mod+N" = {
        action = dms-ipc "notifications" "toggle";
        hotkey-overlay.title = "Toggle Notification Center";
      };
      "Mod+Comma" = {
        action = dms-ipc "settings" "toggle";
        hotkey-overlay.title = "Toggle Settings";
      };
      "Mod+P" = {
        action = dms-ipc "notepad" "toggle";
        hotkey-overlay.title = "Toggle Notepad";
      };
      "Ctrl+Alt+L" = {
        action = dms-ipc "lock" "lock";
        hotkey-overlay.title = "Toggle Lock Screen";
      };
      "Mod+X" = {
        action = dms-ipc "powermenu" "toggle";
        hotkey-overlay.title = "Toggle Power Menu";
      };
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action = dms-ipc "audio" "increment" "3";
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action = dms-ipc "audio" "decrement" "3";
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action = dms-ipc "audio" "mute";
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action = dms-ipc "audio" "micmute";
      };
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action = dms-ipc "brightness" "increment" "5" "";
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action = dms-ipc "brightness" "decrement" "5" "";
      };
      "Mod+Alt+N" = {
        allow-when-locked = true;
        action = dms-ipc "night" "toggle";
        hotkey-overlay.title = "Toggle Night Mode";
      };
      "Mod+V" = {
        action = dms-ipc "clipboard" "toggle";
        hotkey-overlay.title = "Toggle Clipboard Manager";
      };
      "Mod+M" = {
        action = dms-ipc "processlist" "toggle";
        hotkey-overlay.title = "Toggle Process List";
      };
      # Above: Added keys manually from DMS

      "XF86Display".action =
        spawn "sh" "-c"
          "wlr-randr | grep -A5 ^${externalMonitor} | grep -q 'Enabled: yes' && wlr-randr --output ${externalMonitor} --off || wlr-randr --output ${externalMonitor} --on";
      "XF86WLAN".action =
        spawn "sh" "-c"
          "ping -q -c 1 -W 1 1.1.1.1 >/dev/null && ip link set wlan0 down || ip link set wlan0 up";
      # "nmcli networking connectivity | grep -q none && nmcli networking on || nmcli networking off";

      #"XF86NotificationCenter".action = spawn "${./fuzzel-emoji.sh}";
      "XF86NotificationCenter".action = dms-ipc "spotlight" "toggleQuery" ":e";
      "XF86PickupPhone".action = spawn "${../switch-audio-port}";
      # "XF86HangupPhone".action = spawn "${./change-wp.sh}";
      "XF86Favorites".action =
        spawn "sh" "-c"
          "emacsclient --eval '(save-some-buffers t)' 2>/dev/null; systemctl poweroff";

      # "XF86AudioPlay".action = playerctl "play-pause";
      # "XF86AudioStop".action = playerctl "pause";
      # "XF86AudioPrev".action = playerctl "previous";
      # "XF86AudioNext".action = playerctl "next";

      "${modifier}+I".action = playerctl "play-pause";
      "${modifier}+Ctrl+U".action = playerctl "previous";
      "${modifier}+U".action = playerctl "position 3-";
      "${modifier}+Ctrl+o".action = playerctl "next";
      "${modifier}+o".action = playerctl "position 3+";

      # Print screen
      # https://github.com/sodiboo/niri-flake/issues/1380
      "Print".action.screenshot = [ ];
      "Ctrl+Print".action.screenshot-window = [ ];
      "Ctrl+Shift+Print".action.screenshot-screen = [ ];

      # Launchers
      # "${modifier}+D".action = spawn "${pkgs.fuzzel}/bin/fuzzel";
      # "${modifier}+Ctrl+D".action = spawn "${pkgs.raffi}/bin/raffi";
      "${modifier}+Return".action = spawn "${pkgs.foot}/bin/footclient";
      "${modifier}+Alt+H".action = show-hotkey-overlay;
      # "${modifier}+E".action = spawn "emacsclient" "-c";
      # "${modifier}+C".action = spawn "chromium";

      # "Ctrl+Alt+L".action = spawn "sh" "-c" "${pkgs.rbw}/bin/rbw lock; pidof hyprlock >/dev/null || hyprlock";
      # "Shift+Alt+L".action = spawn "sh" "-c" "${pkgs.rbw}/bin/rbw lock; pidof hyprlock >/dev/null || hyprlock && systemctl suspend";

      # Window modifiers
      "${modifier}+Q" = {
        action = close-window;
        repeat = false;
      };
      "${modifier}+W" = {
        action = toggle-overview;
        repeat = false;
      };

      # Set/cycle [S]izes
      "${modifier}+S".action = switch-preset-column-width;
      "${modifier}+7".action = set-column-width "25%";
      "${modifier}+8".action = set-column-width "50%";
      "${modifier}+9".action = set-column-width "75%";
      "${modifier}+0".action = set-column-width "100%";

      # Workspaces
      "${modifier}+1".action = focus-workspace 1;
      "${modifier}+Ctrl+1".action.move-column-to-workspace = 1;
      "${modifier}+2".action = focus-workspace 2;
      "${modifier}+Ctrl+2".action.move-column-to-workspace = 2;
      "${modifier}+3".action = focus-workspace 3;
      "${modifier}+Ctrl+3".action.move-column-to-workspace = 3;
      "${modifier}+4".action = focus-workspace 4;
      "${modifier}+Ctrl+4".action.move-column-to-workspace = 4;

      # Manual column width height
      "${modifier}+Shift+Left".action = set-column-width "-10%";
      "${modifier}+Shift+Right".action = set-column-width "+10%";
      "${modifier}+Shift+Up".action = set-window-height "-10%";
      "${modifier}+Shift+Down".action = set-window-height "+10%";

      # Full screen and switches
      # "${modifier}+Shift+F".action = fullscreen-window;
      "${modifier}+F".action = maximize-column; # full-screen
      "${modifier}+Shift+F".action = expand-column-to-available-width; # "soft"; respecting other windows
      "${modifier}+Ctrl+F".action = toggle-windowed-fullscreen; # software fullscreen

      "${modifier}+T".action = toggle-column-tabbed-display;
      "${modifier}+Left".action = consume-or-expel-window-left;
      "${modifier}+Right".action = consume-or-expel-window-right;
      "${modifier}+Up".action = move-window-up;
      "${modifier}+Down".action = move-window-down;
      "${modifier}+Ctrl+Left".action = move-column-left;
      "${modifier}+Ctrl+Right".action = move-column-right;

      # Floating
      "${modifier}+Period".action = toggle-window-floating;
      "${modifier}+Alt+Period".action = switch-focus-between-floating-and-tiling;

      # H J K L
      "${modifier}+H".action = focus-column-left;
      "${modifier}+Shift+H".action = move-column-left;
      "${modifier}+Ctrl+H".action = focus-monitor-left;
      "${modifier}+Ctrl+Shift+H".action = move-column-to-monitor-left;

      "${modifier}+J".action = focus-window-or-workspace-down;
      "${modifier}+Shift+J".action = move-column-to-workspace-down;
      # "${modifier}+Ctrl+J".action = focus-monitor-down;
      # "${modifier}+Ctrl+Shift+J".action = move-column-to-monitor-down;
      "${modifier}+Ctrl+Alt+J".action = move-workspace-down;

      "${modifier}+K".action = focus-window-or-workspace-up;
      "${modifier}+Shift+K".action = move-column-to-workspace-up;
      # "${modifier}+Ctrl+K".action = focus-monitor-up;
      # "${modifier}+Ctrl+Shift+K".action = move-column-to-monitor-up;
      "${modifier}+Ctrl+Alt+K".action = move-workspace-up;

      "${modifier}+L".action = focus-column-right;
      "${modifier}+Shift+L".action = move-column-right;
      "${modifier}+Ctrl+L".action = focus-monitor-right;
      "${modifier}+Ctrl+Shift+L".action = move-column-to-monitor-right;

      "${modifier}+Escape" = {
        action = toggle-keyboard-shortcuts-inhibit;
        allow-inhibiting = false;
      };
    };
}
