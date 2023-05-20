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

  # bunOverlay = self: super: {
  #   bun = super.bun.overrideAttrs (attr: {
  #     version = "0.5.4";
  #     src = super.fetchzip {
  #       url =
  #         "https://github.com/oven-sh/bun/releases/download/bun-v${self.bun.version}/bun-linux-x64.zip";
  #       sha256 = "O7PAj7cHBr7MhXyefY9W8viU95LphU7avaud3JsEzfA=";
  #     };
  #   });
  # };

  emacsOverlay = (import (fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/b4d748b3b06fece127426314c1e42e238da9c4e7.tar.gz";
    sha256 = "13q7xmwphhfhy8j05y63dkbizx4wdbk6956c5xwckinq10cai534";
  }));

  waylandOverlay = (import "${
      fetchTarball {
        url =
          "https://github.com/nix-community/nixpkgs-wayland/archive/031ace86d48def582fb8f7e098dc9a94fc25c3f7.tar.gz";
        sha256 = "0hdbl2blm5565jbki58vgmxzcfjh68b33pjhsjqpdpc5flynslq7";
      }
  }/overlay.nix");

  # [01.01.2023]
  # Latest release dates from 12.12.2020 and is broken. Master branch seems fixed but ain't pushed to a new release.
  mopidySoundCloudOverlay = self: super: {
    mopidy-soundcloud = super.mopidy-soundcloud.overrideAttrs (attr: {
      src = fetchTarball {
        url =
          "https://github.com/mopidy/mopidy-soundcloud/archive/c61060abd567e2ddf9ee4591b93bd0a20804a9fc.tar.gz";
        sha256 = "0jr7jrcnl9mi2a4dqv0ic81133asbz06r6hgsy5fsrwd1rzrn2nm";
      };
      propagatedBuildInputs = attr.propagatedBuildInputs
        ++ [ super.python310Packages.beautifulsoup4 ];
    });
  };

  # [09.12.2022]
  # TODO - Trouble with waybar (remove overlay after fix)
  # https://github.com/Alexays/Waybar/issues/1852
  waybarOverlay = self: super: {
    waybar = super.waybar.override { wireplumberSupport = false; };
  };
}
