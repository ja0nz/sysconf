/* #+TITLE: Packages in use
   Packages imported by ../_shared/users.nix
*/
{ pkgs, ... }:

let
  sizzy = import ../../_home-manager/sizzy;
  devenv = import (fetchTarball {
    url =
      "https://github.com/cachix/devenv/archive/61033d861900f36bfa6afcd5b8580f098d65e137.tar.gz";
    sha256 = "01adpihld6gff0hbaglwnb0sgch8rm7g41p6970dh7z15vvlkblp";
  });
in {

  # Home manager imports
  imports = map (pkg: ../../_home-manager + pkg) [
    # -- Programs --
    /emacs
    /zathura
    /chromium
    # -- Services --
    /syncthing.nix
    /mopidy.nix
    # -- nix --
    /sway
    /waybar
    /kanshi.nix
    /mako.nix
    /gammastep.nix
    /foot.nix
    /xdg.nix
    /gtk.nix
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
    # -- Hardware connectivity --
    /blueman.nix
    /udiskie.nix
  ];

  # Is a sane 'cat' replacement
  programs.bat.enable = true;

  home.packages = with pkgs; [
    # -- Programs --
    (callPackage sizzy { }) # The browser for Developers & Designers
    # INFO: no wayland support for MATE yet (as of 2022)...
    # (mate.caja-with-extensions.override {
    #   extensions = [ mate.caja-extensions mate.caja-dropbox ];
    # })
    # mate.eom # An image viewing and cataloging program for the MATE desktop
    stremio # A modern media center
    cinnamon.nemo # File browser for Cinnamon
    cinnamon.pix # A generic image viewer from Linux Mint
    okular # KDE document viewer
    helvum # A GTK patchbay for pipewire
    networkmanagerapplet # NetworkManager control applet for GNOME
    neovim # Vim text editor fork focused on extensibility and agility
    anki-bin # Spaced repetition flashcard program
    mpv # ^ General-purpose media player, fork of MPlayer and mplayer2
    wofi-emoji # Emoji picker
    wofi # ^

    # -- System information --
    neofetch # A fast, highly customizable system info script
    du-dust # du + rust = dust. Like du but more intuitive [RUST]
    duf # Disk Usage/Free Utility [GO]
    inxi # A full featured CLI system information tool

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
    dogdns # A user-friendly command-line DNS client. dig on steroids [RUST]
    dmenu # A generic, highly customizable, menu for the X Window System
    networkmanager_dmenu # Small script to manage NetworkManager connections with dmenu
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
    choose # A human-friendly and fast alternative to cut and (sometimes) awk [RUST]
    sd # Intuitive find & replace CLI (sed alternative) [RUST]
    hyperfine # Command-line benchmarking tool [RUST]
    tealdeer # A very fast implementation of tldr in [RUST]
    calc # C-style arbitrary precision calculator
    rlwrap # Readline wrapper for console programs
    just # A handy way to save and run project-specific commands [RUST]
    rm-improved # Replacement for rm with focus on safety [RUST]

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
    niv # Easy dependency management for Nix projects -> good fit with lorri & direnv
    grex # A command-line tool for generating regular expressions from user-provided test cases [RUST]
    tokei # A program that allows you to count your code [RUST]
    devenv.default # Fast, Declarative, Reproducible, and Composable Developer Environments
  ];
}
