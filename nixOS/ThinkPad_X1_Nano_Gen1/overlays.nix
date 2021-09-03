/* #+TITLE: Define some useful overlays

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
      "https://github.com/nix-community/emacs-overlay/archive/8cdecfcef62843fe4270ca0c5d0d623badf0278b.tar.gz";
    sha256 = "0vj53yzwv3jjla9ci3ppw505kv112f9h6xcb82bq82wix06k1qv3";
  }));

  myWaylandOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/colemickens/nixpkgs-wayland/archive/b50e8f3b485453f9ae27c7f0e818c1c123a69648.tar.gz";
    sha256 = "11nss0p88c4n8dkhjnvkmvfr46baly1d0zhmqww58zd669kgaql4";
  }));
}
