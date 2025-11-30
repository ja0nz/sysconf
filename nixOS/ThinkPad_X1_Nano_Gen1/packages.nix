/*
  #+TITLE: Packages in use
  Packages imported by ../_shared/users.nix
*/
{ pkgs, ... }:

let
  sizzy = import ../../_home-manager/sizzy;
  sandbox = import ../../_home-manager/sandbox;
in
{

  # Home manager imports
  imports = map (pkg: ../../_home-manager + pkg) [
    # -- Programs --
    /emacs
    /neovim
    # /zathura
    /chromium
    /helix.nix
    # -- Services --
    /syncthing.nix
    /systemd.nix
    # /swww.nix
    /gnome.nix
    # -- nix --
    # /sway
    /niri
    /hyprlock.nix
    /waybar
    /kanshi.nix
    /mako.nix
    /gammastep.nix
    /foot.nix
    /fuzzel.nix
    /xdg.nix
    /gtk.nix
    /darkman.nix
    /bat.nix
    # -- SHELL --
    /fish.nix
    /mcfly.nix
    /zoxide.nix
    /starship.nix
    /lsd.nix
    /fzf.nix
    /lorri.nix
    /direnv.nix
    /git.nix
    /gpg.nix
    /ssh.nix
    /cliphist.nix
    /yazi.nix
    # -- Hardware connectivity --
    /blueman.nix
    /udiskie.nix
    # /networkmanager_dmenu.nix
  ];

  home.packages = with pkgs; [
    # -- Programs --
    # (callPackage sizzy { }) # The browser for Developers & Designers
    (callPackage sandbox { })
    # INFO: no wayland support for MATE yet (as of 2022)...
    # (mate.caja-with-extensions.override {
    #   extensions = [ mate.caja-extensions mate.caja-dropbox ];
    # })
    # mate.eom # An image viewing and cataloging program for the MATE desktop
    #stremio # A modern media center
    iwgtk # Lightweight, graphical wifi management utility for Linux
    pwvucontrol # Pipewire Volume Control
    # networkmanagerapplet # NetworkManager control applet for GNOME
    readest # Modern, feature-rich ebook reader
    remnote # Note-taking application focused on learning and productivity
    # anki-bin # Spaced repetition flashcard program
    # mpv # ^ General-purpose media player, fork of MPlayer and mplayer2

    # -- GNOME --
    amberol
    #cavalier
    (celluloid.override { youtubeSupport = true; })
    nautilus
    gnome-control-center
    gnome-text-editor
    file-roller
    (papers.override { supportNautilus = true; })
    loupe
    keypunch
    eyedropper

    # -- System information --
    fastfetchMinimal # A fast, highly customizable system info script
    dust # du + rust = dust. Like du but more intuitive [RUST]
    duf # Disk Usage/Free Utility [GO]
    inxi # A full featured CLI system information tool
    libnotify # A library that sends desktop notifications to a notification daemon
    wl-clipboard # Command-line copy/paste utilities for Wayland

    # -- Find and discover --
    ripgrep # A utility that combines the usability of The Silver Searcher [RUST]
    fd # A simple, fast and user-friendly alternative to find [RUST]
    as-tree # Print a list of paths as a tree of paths [RUST]

    # -- Process management --
    htop # An interactive process viewer for Linux
    procs # A modern replacement for ps written in [RUST]
    bottom # A cross-platform graphical process/system monitor with a customizable interface [RUST]

    # -- Networking --
    gping # Ping, but with a graph [RUST]
    curlie # Frontend to curl that adds the ease of use of httpie [GO]
    bandwhich # A CLI utility for displaying current network utilization [RUST]
    xh # HTTPie; Friendly and fast tool for sending HTTP requests [RUST]
    doggo # Command-line DNS Client for Humans. Written in Golang [RUST]
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    curl # A command line tool for transferring files with URL syntax
    maestral # Open-source Dropbox client for macOS and Linux

    # -- XDG MIME --
    file # A program that shows the type of files
    xdg-utils # A set of command line tools that assist applications desktop integration
    shared-mime-info # A database of common MIME types

    # -- Sound and light management --
    playerctl # Command-line utility for controlling media players that implement MPRIS
    alsa-utils # ALSA, the Advanced Linux Sound Architecture utils

    # -- Security --
    cryptsetup # LUKS for dm-crypt

    # -- Command Line Utilities --
    sd # Intuitive find & replace CLI (sed alternative) [RUST]
    hyperfine # Command-line benchmarking tool [RUST]
    tealdeer # A very fast implementation of tldr in [RUST]
    navi # An interactive cheatsheet tool for the command-line and application launchers [RUST]
    calc # C-style arbitrary precision calculator
    rlwrap # Readline wrapper for console programs
    just # A handy way to save and run project-specific commands [RUST]
    rm-improved # Replacement for rm with focus on safety [RUST]
    nix-search-cli # CLI for searching packages on search.nixos.org
    aider-chat

    # -- File Generators --
    pandoc # Conversion betrween markup formats
    graphviz # Graph visualization tools
    graph-easy # Render/convert graphs in/from various formats
    ditaa # Convert ascii art diagrams into proper bitmap graphics
    unzip # An extraction utility for archives compressed in .zip format

    # --- Programming --
    exercism # A Go based command line tool for exercism.io
    nodejs # Some globals depend on this
    python3 # Some globals depend on this
    grex # A command-line tool for generating regular expressions from user-provided test cases [RUST]
    tokei # A program that allows you to count your code [RUST]
    devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
  ];
}
