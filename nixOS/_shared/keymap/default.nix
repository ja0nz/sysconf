/* #+TITLE: Keymap Configuration
   Set up keymaps. Sway window manager config keyboard settings may depend on this.
*/
{ ... }:

{
  services.xserver.extraLayouts = {
    noted = {
      description = "See https://github.com/dariogoetz/noted-layout";
      languages = [ ];
      symbolsFile = ./noted;
    };
  };

  # Console settings
  console = {
    # keyMap = ./noted.map;
    keyMap = "neo";
  };

}
