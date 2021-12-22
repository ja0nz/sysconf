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

  swaylock-effectsOverlay = self: super: {
    swaylock-effects = super.swaylock-effects.overrideAttrs (attr: {
      src = builtins.fetchTarball {
        url =
          "https://github.com/mortie/swaylock-effects/archive/a8fc557b86e70f2f7a30ca9ff9b3124f89e7f204.tar.gz";
        sha256 = "0f9571blnn7lg317js1j1spc5smz69i5aw6zkhskkm5m633rrpqq";
      };
    });
  };

  nixCommunity = (import (builtins.fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/f0d9f153102fa445792e2bf2dcf2fa39b7f41af9.tar.gz";
    sha256 = "1kdhvigyd9ifj368fwdbpgf5xz69rkffacsvxi81m3glynbnn633";
  }));

  myWaylandOverlay = (import "${
      builtins.fetchTarball {
        url =
          "https://github.com/colemickens/nixpkgs-wayland/archive/1e481bafca9e03ead4b85e4f46d8d959c5f9b11c.tar.gz";
        sha256 = "0zl2h9pvc1sm7j4krmw7ccrf7jqhxilhyxmvsx70400ahmdapxwi";
      }
    }/overlay.nix");
}
