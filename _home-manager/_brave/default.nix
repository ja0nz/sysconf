/*
  #+TITLE: Brave Browser
  #+FILETAGS: :program:

  * Mandatory configuration
   Add your extensions (id can be found in URL)
  * Optional configuration
  ** Vimium
     Manual restore ./vimium-options.json
     In Brave/Chrome: Vimum -> Settings -> Advanced options
*/
{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # I don't care about cookies
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "cdockenadnadldjbbgcallicgledbeoc"; } # VisBug
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
      { id = "hoombieeljmmljlkjmnheibnpciblicm"; } # Language Learning Netflix
    ];
  };
}
