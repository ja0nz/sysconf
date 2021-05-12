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
      "https://github.com/nix-community/emacs-overlay/archive/b74d4784e7a508f1a4eeec588c4057510ac2fbbb.tar.gz";
    sha256 = "193lxmn6k97d169yfh1271r3kndhs0y1sgspvpqqv2x3si21xgj7";
  }));

  myWaylandOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/colemickens/nixpkgs-wayland/archive/a09b5f0c0f52d8edc2effa372309a136d704903f.tar.gz";
    sha256 = "059kq6x6pznv8gqw8q03l5qf7wkz7mpfsl0lv65vl2ya8v1b3krx";
  }));
}
