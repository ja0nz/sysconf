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
      "https://github.com/nix-community/emacs-overlay/archive/28e2a59713f822679a174720ad3fe70554ab0457.tar.gz";
    sha256 = "0yv3rl96vwg5ggvk3dpd2nlrd4gbhlz6kc0fipgbr896crrwnlns";
  }));

  waylandOverlay = (import "${
      builtins.fetchTarball {
        url =
          "https://github.com/colemickens/nixpkgs-wayland/archive/a62fa62ef9159d5bb916c2123a1c40cfa7d83b76.tar.gz";
        sha256 = "16hw650drdw4cicl3ziax4fy7a9kn55hz1dy06kf02v1hy6jbf8h";
      }
    }/overlay.nix");
}
