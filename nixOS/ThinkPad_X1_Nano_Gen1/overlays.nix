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
      "https://github.com/nix-community/emacs-overlay/archive/011ec0706fa17de340c96d7d393c00af41f65cab.tar.gz";
    sha256 = "0gkz4hrhp7mmf1hanpz0sij00gxy8c3rgckk35wm8q4z7zq8bqs9";
  }));

  myWaylandOverlay = (import "${
      builtins.fetchTarball {
        url =
          "https://github.com/colemickens/nixpkgs-wayland/archive/31ccc1c37366d937da9dae7214550b54a8ee6df4.tar.gz";
        sha256 = "0isha29n7kjd33ljlw8p8kjx98a87bzx2j0rxpfh0q01mf3ljcx6";
      }
    }/overlay.nix");
}
