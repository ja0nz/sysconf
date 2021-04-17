/*
Other options:
Manual restore ./vimium-options.json (Advanced options in vimium settings)
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
