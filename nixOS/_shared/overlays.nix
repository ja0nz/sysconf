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
      "https://github.com/nix-community/emacs-overlay/archive/c78b0626a69b1aafd249d574b9a2a63a6ae87faf.tar.gz";
    sha256 = "05rb7rnv2mhzcxz7j885lvc8j9vbm2rj2h42ixmjxl4cj2s1nnlr";
  }));

  myWaylandOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/colemickens/nixpkgs-wayland/archive/2e3d3157cb58f070eae6ef42147b0aad682b1632.tar.gz";
    sha256 = "1dm322k6p4w4v88gw2d14jxb1xh8arr9kp56azw5b2kdbwiciywc";
  }));
}
