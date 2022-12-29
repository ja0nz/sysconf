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

  emacsOverlay = (import (fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/74a1e57fc7228d715c666172ffe11e38ab31e312.tar.gz";
    sha256 = "0hfzzfw0jf5apwka65pk4pdc30jyisp7ga0zjda242rwr7ymi34p";
  }));

  waylandOverlay = (import "${
      fetchTarball {
        url =
          "https://github.com/nix-community/nixpkgs-wayland/archive/01aff1b07604cd98527f334089026f9b450c83cf.tar.gz";
        sha256 = "0li29pl7dk1nwghm641ibznn0nq66sy856kydymqq7ndisdqb3rz";
      }
    }/overlay.nix");

  # [01.01.2023]
  # Latest release dates from 12.12.2020 and is broken. Master branch seems fixed but ain't pushed to a new release.
  mopidySoundCloudOverlay = self: super: {
    mopidy-soundcloud = super.mopidy-soundcloud.overrideAttrs (attr: {
      src = fetchTarball {
        url = "https://github.com/mopidy/mopidy-soundcloud/archive/fc766b0bf17feb4fc989029b92a315a10ff453ee.tar.gz";
        sha256 = "0gqlgcq9jd8mlmdc9ivwxm1r00h1gwc6a5alhjjalairzdnl3yrd";
      };
      propagatedBuildInputs = attr.propagatedBuildInputs ++ [ super.python310Packages.beautifulsoup4 ];
    });
  };

  # [09.12.2022]
  # TODO - Trouble with waybar (remove overlay after fix)
  # https://github.com/Alexays/Waybar/issues/1852
  waybarOverlay = self: super: {
    waybar = super.waybar.override { wireplumberSupport = false; };
  };
}
