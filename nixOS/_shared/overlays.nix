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
      "https://github.com/nix-community/emacs-overlay/archive/240f965f9821f4df439b27fdfe406db6d2755986.tar.gz";
    sha256 = "07x78wx0c8301llwwirf7w21p6r6qx551m5c9j88mxcz70jfkj4b";
  }));

  myWaylandOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/colemickens/nixpkgs-wayland/archive/9c83ef887821fadeb76adef5bdf1b327c6d0919c.tar.gz";
    sha256 = "0pwl7k1ihcfj0cdhcgq70b5m2xqvqdgn0n3p9qsx6jp3v2q8wfnp";
  }));
}
