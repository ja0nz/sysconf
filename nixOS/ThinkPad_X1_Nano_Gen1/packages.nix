{ pkgs, config, ... }:

let sizzy = import ./sizzy;
in {
  home.packages = with pkgs;
    [
    # Programs
    emacs                     # The extensible, customizable GNU text editor
    brave                     # Privacy-oriented browser for Desktop and Laptop computers
# chromium                  # An open web browser built from Firefox source tree (with plugins: )
    (mate.caja-with-extensions.override { extensions = [ mate.caja-extensions mate.caja-dropbox ]; })
    mate.eom                  # An image viewing and cataloging program for the MATE desktop
    okular                   # KDE document viewer

    # Online services
    dropbox-cli             # Command line client for the dropbox daemon

    # Informative Systems
    neofetch                 # A fast, highly customizable system info script
    inxi                     # A full featured CLI system information tool

    # Find and discover
    exa                      # Replacement for 'ls' written in Rust
    tree                     # Command to produce a depth indented directory listing
    fzf                      # A command-line fuzzy finder written

    # Process management
    htop                     # An interactive process viewer for Linux
    psmisc                   # A set of small useful utilities that use the proc filesystem - pstree

    # XDG MIME
    file                     # A program that shows the type of files
    xdg_utils                # A set of command line tools that assist applications desktop integration
    shared-mime-info         # A database of common MIME types

    # Networking
    httpie                   # A command line HTTP client whose goal is to make CLI human-friendly
    wget                     # Tool for retrieving files using HTTP, HTTPS, and FTP
    curl                     # A command line tool for transferring files with URL syntax

    # Command Line Utilities
    calc # C-style arbitrary precision calculator
    rlwrap # Readline wrapper for console programs

    # Sound Control
    pavucontrol              # PulseAudio Volume Control
    playerctl                # Command-line utility for controlling media players that implement MPRIS

    # Security
    cryptsetup               # LUKS for dm-crypt

    # Dictionaries
    aspell                   # Spell checker for many languages
    aspellDicts.en           # Aspell dictionary for English
    aspellDicts.de           # Aspell dictionary for German

    # Emails
    mu                        # A collection of utilties for indexing and searching Maildirs
    isync                     # Free IMAP and MailDir mailbox synchronizer

    # Database (org-roam)
    sqlite # A self-contained, serverless, zero-configuration SQL db engine

    # File Generators
    pandoc # Conversion betrween markup formats
    graphviz # Graph visualization tools
    ditaa # Convert ascii art diagrams into proper bitmap graphics
    jq # A lightweight and flexible command-line JSON processor

    # Dev
    python3
    nixfmt # An opinionated formatter for Nix
    #    (callPackage sizzy {})    # The browser for Developers & Designers
    devd # A local webserver for developers
    yarn # Fast, reliable, and secure dependency management for javascript
  ];
}
