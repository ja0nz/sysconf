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
      "https://github.com/nix-community/emacs-overlay/archive/2f7fff8ee668c01803cab2f0847151fdf647134e.tar.gz";
    sha256 = "0pshwldb93g88d8mh8pfqzplhady2wspa9vjbqyshnbb7h2k717s";
  }));

  waylandOverlay = (import "${
      builtins.fetchTarball {
        url =
          "https://github.com/colemickens/nixpkgs-wayland/archive/2643b59b1b3551d03448208ad2d690032e519dc9.tar.gz";
        sha256 = "1b22ygr9ipka1wa8z618d5w1pfpbfz9q4w2v5wzxzsd8s4024342";
      }
    }/overlay.nix");
}
