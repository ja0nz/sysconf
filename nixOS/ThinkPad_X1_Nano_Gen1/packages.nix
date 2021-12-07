/* #+TITLE: Packages in use
   Packages imported by ../_shared/users.nix
*/
{ pkgs, ... }:

let sizzy = import ../../_home-manager/sizzy;
in {

  # Home manager imports
  imports = map (pkg: ../../_home-manager + pkg) [
    # -- Programs --
    /emacs
    /zathura
    /chromium
    # -- Services --
    /dropbox.nix
    /nextcloud.nix
    # -- GUI --
    /sway
    /waybar
    /kanshi.nix
    /mako.nix
    /gammastep.nix
    /alacritty.nix
    /xdg.nix
    /gtk.nix
    # -- SHELL --
    /fish.nix
    #/nushell.nix
    /zoxide.nix
    /starship.nix
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
    (callPackage sizzy { }) # The browser for Developers & Designers
    (mate.caja-with-extensions.override {
      extensions = [ mate.caja-extensions mate.caja-dropbox ];
    })
    mate.eom # An image viewing and cataloging program for the MATE desktop
    okular # KDE document viewer
    pavucontrol # PulseAudio Volume Control
    networkmanagerapplet # NetworkManager control applet for GNOME
    neovim # Vim text editor fork focused on extensibility and agility
    brave # Privacy-oriented browser for Desktop and Laptop computers

    # -- System information --
    neofetch # A fast, highly customizable system info script
    inxi # A full featured CLI system information tool

    # -- Find and discover --
    tree # Command to produce a depth indented directory listing
    fzf # A command-line fuzzy finder written
    ripgrep # A utility that combines the usability of The Silver Searcher
    fd # A simple, fast and user-friendly alternative to find

    # -- Process management --
    htop # An interactive process viewer for Linux
    psmisc # A set of small useful utilities that use the proc filesystem - pstree

    # -- Networking --
    dmenu # A generic, highly customizable, menu for the X Window System
    networkmanager_dmenu # Small script to manage NetworkManager connections with dmenu
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

    # --- Programming --
    nodejs # Some globals depend on this
    python3 # Some globals depend on this
    niv # Easy dependency management for Nix projects -> good fit with lorri & direnv
  ];
}
