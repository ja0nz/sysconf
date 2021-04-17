/*
Other options:
Manual restore of _static/vimium-options.json (Advanced options)
*/
{ pkgs, ... }:

{
  programs.chromium = {
   enable = true;
   package = pkgs.brave;
   extensions = [
     { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
     { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
   ];
 };
}
