/* #+TITLE: Dropbox - Enable dropbox daemon
   #+FILETAGS: :networking:services:

   * Mandatory configuration
   For autostarting dropbox you probably still need to put a
   ~dropbox start~
   somewhere (I put my into the sway config).
*/
{ ... }:

{
  services.dropbox = { enable = true; };
}
