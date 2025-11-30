/*
  #+TITLE: Emacs
  #+FILETAGS: :program:

  * Mandatory configuration

  * Optional configuration
   Add your config.el files or untangle them
*/
{
  pkgs ? import <nixpkgs> { },
}:

pkgs.writeShellApplication {
  name = "sandbox";

  # Optional: add tools your script expects
  runtimeInputs = [
    pkgs.bubblewrap
  ];

  text = ''
    exec ${toString ./sandbox.sh} "$@"
  '';
}
