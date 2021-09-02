/* #+TITLE: Ungoogled Chrome Browser
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
    package = pkgs.ungoogled-chromium;
    extensions = [
      {
        id = "ocaahdebbfolfmndjeplogmgcagdmblk"; # chromium-web-store
        updateUrl =
          "https://raw.githubusercontent.com/NeverDecaf/chromium-web-store/master/updates.xml";
      }
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # I don't care about cookies
      { id = "cdockenadnadldjbbgcallicgledbeoc"; } # VisBug
      {
        id = "dbepggeogbaibhgnhhndojpepiihcmeb";
      } # Vimium
      # TODO Language Reactor on hold because google sign in is not working
      # { id = "hoombieeljmmljlkjmnheibnpciblicm"; }
    ];
  };
}
