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

  nixCommunity = (import (builtins.fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/4470eebb2f0000d27b52f09c1f30054219bea411.tar.gz";
    sha256 = "15aazi7pvv8w7q2jf4n7i0h8q3xk0fpam0hknk3r4mqdv54khr6b";
  }));

  myWaylandOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/colemickens/nixpkgs-wayland/archive/16db348eae1baabd8856f73d0939fa1dba46a9cb.tar.gz";
    sha256 = "03a4knk602fzc9qisp7k29nahvv7prrb5kdw51rsi1hcmxhfwnnn";
  }));
}
