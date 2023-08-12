/* #+TITLE: Keymap Configuration
   Set up keymaps. This will interact with the sway window manager config.
*/
{ ... }:

{
  services.xserver.extraLayouts = {
    noted = {
      description = "See https://github.com/dariogoetz/noted-layout";
      languages = [ "de" ];
      symbolsFile = ./noted;
    };
  };

  # Console settings
  console = {
    # keyMap = ./noted.map;
    keyMap = "neo";
  };

}
