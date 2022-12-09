/* #+TITLE: Define some useful overlays

   This file defines some overlays which are needed by wayland/sway and the
   Emacs GCC version. Imported by ../_shared/users.nix

   * Mandatory configuration
    You may remove the sha256 assignments or update them to stay updated.
    SHA256 checksums are a good practice to roll back if things break.

    There is a package for auto insertation:
    -> haskellPackages.update-nix-fetchgit
    Just run ~update-nix-fetchgit overlays.nix~ from time to time.
*/

{
  # TODO Fixed upstream; Leave this here for reference
  # discordpyOverlay = self: super: {
  #   python37 = super.python37.override {
  #     packageOverrides = pself: psuper: {
  #       discordpy = psuper.discordpy.overrideAttrs (attrs: {
  #         patchPhase = ''
  #           substituteInPlace "requirements.txt" \
  #             --replace "aiohttp>=3.6.0,<3.7.0" "aiohttp>=3.6.0,<3.8.0" \
  #         '';
  #       });
  #     };
  #   };
  # };

  # swaylockOverlay = self: super: {
  #   swaylock-effects = super.swaylock-effects.overrideAttrs (attr: {
  #     src = builtins.fetchTarball {
  #       url =
  #         "https://github.com/mortie/swaylock-effects/archive/a8fc557b86e70f2f7a30ca9ff9b3124f89e7f204.tar.gz";
  #       sha256 = "0f9571blnn7lg317js1j1spc5smz69i5aw6zkhskkm5m633rrpqq";
  #     };
  #   });
  # };

  emacsOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/49e3c66d211d5110909375fe48d85c3c43753d61.tar.gz";
    sha256 = "0mgpd3fvv9ksvyn6r3km11599phxbylhjs37dfl2sl8p4ffwrzhb";
  }));

  waylandOverlay = (import "${
      builtins.fetchTarball {
        url =
          "https://github.com/nix-community/nixpkgs-wayland/archive/7a9e28e2fb249bc6ff31b668ccd3b005e5157aaa.tar.gz";
        sha256 = "18w85w6v6lcmv2hiyzyii9fg0gygig98rfpgazjwv1z71nd768fy";
      }
    }/overlay.nix");

  waybarOverlay = self: super: {
    waybar = super.waybar.override { wireplumberSupport = false; };
  };
}
