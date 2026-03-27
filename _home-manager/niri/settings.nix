{
  config,
  pkgs,
  ...
}:
let
  pointer = config.home.pointerCursor;
in
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      environment = {
        XDG_CURRENT_DESKTOP = "gnome";
        DISPLAY = null;
        GDK_BACKEND = "wayland,x11";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        _JAVA_AWT_WM_NONREPARENTING = "1";
      };
      input = {
        keyboard.xkb = {
          layout = "de";
          variant = "neo_qwertz";
        };

        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "adaptive";
        };
        mouse = {
          scroll-factor = 2;
        };
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "90%";
        };
        # Center mouse in focused window
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };
      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d-%H:%M:%S.png";
      overview = {
        workspace-shadow.enable = false;
        backdrop-color = "transparent";
      };
      gestures = {
        hot-corners.enable = false;
      };
      cursor = {
        size = pointer.size;
        theme = "${pointer.name}";
      };
      layout = {
        shadow.enable = true;
        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        default-column-width = {
          proportion = 0.5;
        };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
