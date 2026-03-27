/*
  #+TITLE: Ungoogled Chrome Browser
  #+FILETAGS: :program:

  * Mandatory configuration
   Add your extensions (id can be found in URL)
  * Optional configuration
   - Language Reactor allow cookies -> Settings; Cookies; cookies allowed to [*.]languagereactor.com
  ** Vimium
     Manual restore ./vimium-options.json
     In Brave/Chrome: Vimum -> Settings -> Advanced options
*/
{ pkgs, ... }:

{
  nixpkgs.config.chromium.enableWideVine = true;
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [
      # https://github.com/ungoogled-software/ungoogled-chromium/blob/master/docs/flags.md
      "--password-store=basic"
      "--extension-mime-request-handling=always-prompt-for-install"
      "--scroll-tabs=never"
      "--remove-tabsearch-button"
      "--force-punycode-hostnames"
      "--show-avatar-button=never"
      "--hide-crashed-bubble"
    ];
    extensions = [
      {
        id = "ocaahdebbfolfmndjeplogmgcagdmblk"; # chromium-web-store
        updateUrl = "https://raw.githubusercontent.com/NeverDecaf/chromium-web-store/master/updates.xml";
      }
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # I don't care about cookies
      { id = "cdockenadnadldjbbgcallicgledbeoc"; } # VisBug
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
      { id = "hecfkgekabkkhiidlinmifelhdooeool"; } # Fraidycay
      { id = "aapbdbdomjkkjkaonfhkkikfgjllcleb"; } # Google Translate
      { id = "hoombieeljmmljlkjmnheibnpciblicm"; } # Language Reactor
      { id = "limifnkopacddgpihodacjeckfkpbfoe"; } # Mastodon View Profile
      { id = "amakigfkijfllhcekpkcknefggimkgbm"; } # Fishtail
    ];
  };
}
