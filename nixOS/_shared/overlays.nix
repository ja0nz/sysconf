/* #+TITLE: Define some useful overlays
   #+FILETAGS: :user:sway:

   This file defines some overlays which are needed by wayland/sway and the
   Emacs GCC version.

   * Mandatory configuration
    You may remove the sha256 assignments or update them to stay updated.
    SHA256 checksums are a good practice to roll back if things break.

    There is a package for auto insertation:
    -> haskellPackages.update-nix-fetchgit
    Just run ~update-nix-fetchgit overlays.nix~ from time to time.
*/

{
  discordpyOverlay = self: super: {
    python37 = super.python37.override {
      packageOverrides = pself: psuper: {
        discordpy = psuper.discordpy.overrideAttrs (attrs: {
          patchPhase = ''
            substituteInPlace "requirements.txt" \
              --replace "aiohttp>=3.6.0,<3.7.0" "aiohttp>=3.6.0,<3.8.0" \
          '';
        });
      };
    };
  };

  nixCommunity = (import (builtins.fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/73538fa26b715cc7b4d265ee7b0c582e6c27fe4c.tar.gz";
    sha256 = "0r7axyvhffl9z1lhq6j1czj0h4q7qpwm7lgfr4myjawhvvzz590h";
  }));

  myWaylandOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/colemickens/nixpkgs-wayland/archive/60657d00538514b8ba565537a51e0d5b59f05d44.tar.gz";
    sha256 = "1gcrykq94h58j29251cxslcbddaiqyl78hjmjdaqcj3kmdwmaars";
  }));
}
