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
      "https://github.com/nix-community/emacs-overlay/archive/d1471c0e9049772e84bfe11707ab8b9c133b49e8.tar.gz";
    sha256 = "0h5gzpjr8pcrwrh9nr0vrjzrnvski5mr02n63m9vwyqb37xsv90c";
  }));

  myWaylandOverlay = (import "${
      builtins.fetchTarball {
        url =
          "https://github.com/colemickens/nixpkgs-wayland/archive/da0699ec283382fcc018072bafd573b4d7257d0e.tar.gz";
        sha256 = "0h6h63rdxi8xl6hg0010y8nlf2a1v9d1bwx11m090dkxzs9nnczx";
      }
    }/overlay.nix");
}
