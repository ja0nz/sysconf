/*
  #+TITLE: XDG - base directory specification for X11/Wayland
  #+FILETAGS: :ui:

  * Optional configuration
   This mimeapps list is not crucial. It's just replicating the values
   set by the system. You may easily go without using this module.
*/
{
  config,
  pkgs,
  ...
}:
let
  browser = [ "chromium-browser" ];
  imageViewer = [ "org.gnome.Loupe" ];
  videoPlayer = [ "io.github.celluloid_player.Celluloid" ];
  audioPlayer = [ "io.bassi.Amberol" ];

  xdgAssociations =
    type: program: list:
    builtins.listToAttrs (
      map (e: {
        name = "${type}/${e}";
        value = program;
      }) list
    );

  image = xdgAssociations "image" imageViewer [
    "png"
    "jpg"
    "jpeg"
    "gif"
    "webp"
    "bmp"
    "tiff"
    "tif"
    "ico"
    "svg"
    "avif"
    "heic"
    "heif"
  ];
  video = xdgAssociations "video" videoPlayer [
    "mp4"
    "avi"
    "mkv"
    "mov"
    "wmv"
    "flv"
    "webm"
    "m4v"
    "3gp"
    "ogv"
    "ts"
    "mts"
    "m2ts"
  ];
  audio = xdgAssociations "audio" audioPlayer [
    "mp3"
    "flac"
    "wav"
    "aac"
    "ogg"
    "oga"
    "opus"
    "m4a"
    "wma"
    "ape"
    "alac"
    "aiff"
  ];
  browserTypes =
    (xdgAssociations "application" browser [
      "json"
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "ftp"
      "http"
      "https"
      "unknown"
    ]);

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) (
    {
      "application/pdf" = [ "org.gnome.Papers" ];
      "application/zip" = [ "org.gnome.FileRoller" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller" ];
      "application/x-rar-compressed" = [ "org.gnome.FileRoller" ];
      "application/x-tar" = [ "org.gnome.FileRoller" ];
      "application/gzip" = [ "org.gnome.FileRoller" ];
      "text/html" = browser;
      "text/plain" = [ "org.gnome.TextEditor" ];
      "text/markdown" = [ "org.gnome.TextEditor" ];
      "text/x-python" = [ "org.gnome.TextEditor" ];
      "text/x-shellscript" = [ "org.gnome.TextEditor" ];
      "application/json" = [ "org.gnome.TextEditor" ];
      "application/xml" = [ "org.gnome.TextEditor" ];
      "application/javascript" = [ "org.gnome.TextEditor" ];
      "text/css" = [ "org.gnome.TextEditor" ];
      "text/x-c" = [ "org.gnome.TextEditor" ];
      "text/x-c++" = [ "org.gnome.TextEditor" ];
      "text/x-rust" = [ "org.gnome.TextEditor" ];
      "text/x-nix" = [ "org.gnome.TextEditor" ];
      "x-scheme-handler/chrome" = [ "chromium-browser" ];
    }
    // image
    // video
    // audio
    // browserTypes
  );
in
{
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };

  # used by `gio open` and xdp-gtk
  home.packages = [
    # used by `gio open` and xdp-gtk
    (pkgs.writeShellScriptBin "xdg-terminal-exec" ''
      foot start "$@"
    '')
    pkgs.xdg-utils
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
