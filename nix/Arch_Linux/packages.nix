{ pkgs, ... }:

let sizzy = import ../../home-manager/sizzy;
in {

  # Home manager imports
  imports = map (pkg: ../../_home-manager + pkg) [
    # -- Programs --
    /emacs.nix
    /zathura.nix
    # -- GUI --
    /sway.nix
    /mako.nix
    /waybar.nix
    /gammastep.nix
    /alacritty.nix
    /xdg.nix
    /gtk.nix
    # -- SHELL --
    /fish.nix
    /exa.nix
    /lorri.nix
    /direnv.nix
    /git.nix
    /gpg.nix
    /ssh.nix
    # -- Emails  --
    /emails.nix
    # -- Hardware connectivity --
    /blueman.nix
    /udiskie.nix
  ];

  home.packages = with pkgs; [
    # -- Programs --
    brave # Privacy-oriented browser for Desktop and Laptop computers
    (mate.caja-with-extensions.override {
      extensions = [ mate.caja-extensions mate.caja-dropbox ];
    })
    mate.eom # An image viewing and cataloging program for the MATE desktop
    okular # KDE document viewer
    pavucontrol # PulseAudio Volume Control

    # -- Online services --
    dropbox-cli # Command line client for the dropbox daemon

    # -- System information --
    neofetch # A fast, highly customizable system info script
    inxi # A full featured CLI system information tool

    # -- Find and discover --
    tree # Command to produce a depth indented directory listing
    fzf # A command-line fuzzy finder written
    ripgrep # A utility that combines the usability of The Silver Searcher

    # -- Process management --
    htop # An interactive process viewer for Linux
    psmisc # A set of small useful utilities that use the proc filesystem - pstree

    # -- Networking --
    httpie # A command line HTTP client whose goal is to make CLI human-friendly
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    curl # A command line tool for transferring files with URL syntax

    # -- XDG MIME --
    file # A program that shows the type of files
    xdg_utils # A set of command line tools that assist applications desktop integration
    shared-mime-info # A database of common MIME types

    # -- Sound and light management --
    playerctl # Command-line utility for controlling media players that implement MPRIS

    # -- Security --
    cryptsetup # LUKS for dm-crypt

    # -- Command Line Utilities --
    calc # C-style arbitrary precision calculator
    rlwrap # Readline wrapper for console programs

    # -- File Generators --
    pandoc # Conversion betrween markup formats
    graphviz # Graph visualization tools
    ditaa # Convert ascii art diagrams into proper bitmap graphics
    jq # A lightweight and flexible command-line JSON processor

    # For emacs: Dictionaries
    aspell # Spell checker for many languages
    aspellDicts.en # Aspell dictionary for English
    aspellDicts.de # Aspell dictionary for German

    # For emacs: Database (org-roam)
    sqlite # A self-contained, serverless, zero-configuration SQL db engine

    # -- Software Development --
    python3 # A high-level dynamically-typed programming language
    nixfmt # An opinionated formatter for Nix
    manix # A Fast Documentation Searcher for Nix
    #    (callPackage sizzy {})    # The browser for Developers & Designers
    devd # A local webserver for developers
    yarn # Fast, reliable, and secure dependency management for javascript
  ];
}