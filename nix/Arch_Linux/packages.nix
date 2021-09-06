/* #+TITLE: Packages in use
   Packages imported by ./home.nix
*/
{ pkgs, ... }:

{

  # Home manager imports
  imports = map (pkg: ../../_home-manager + pkg) [
    # -- Programs --
    # -- GUI --
    #/alacritty.nix
    /xdg.nix
    #/gtk.nix
    # -- SHELL --
    /fish.nix
    /exa.nix
    /lorri.nix
    /direnv.nix
    /git.nix
    /gpg.nix
    #/ssh.nix
    # -- Emails  --
    # -- Hardware connectivity --
    /udiskie.nix
  ];

  home.packages = with pkgs; [
    # -- Programs --
    neovim # Vim text editor fork focused on extensibility and agility

    # -- Online services --
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
    # -- XDG MIME --
    # -- Sound and light management --
    # -- Security --
    # -- Command Line Utilities --
    # -- File Generators --
    # -- Programming --
  ];
}
