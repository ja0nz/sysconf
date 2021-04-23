/* Other options:
   Manual restore ./vimium-options.json (Advanced options in vimium settings)
*/
{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "cdockenadnadldjbbgcallicgledbeoc"; } # VisBug
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
      { id = "hoombieeljmmljlkjmnheibnpciblicm"; } # Language Learning Netflix
    ];
  };
}
