/* #+TITLE: Define some useful overlays

   This file defines some overlays which are needed by wayland/sway and the
   Emacs GCC version. Imported by ../_shared/users.nix

   * Mandatory configuration
    You may remove the sha256 assignments or update them to stay updated.
    SHA256 checksums are a good practice to roll back if things break.

    There is a package for auto insertation:
    -> update-nix-fetchgit
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
      "https://github.com/nix-community/emacs-overlay/archive/cacd688b09b4ef4ddff5ff12ede2f24ca25119ad.tar.gz";
    sha256 = "1kzi0dhnckndc9ax44cfdb75v6zqqvax99gkky7qmyra1hq3452z";
  }));

  waylandOverlay = (import "${
      fetchTarball {
        url =
          "https://github.com/nix-community/nixpkgs-wayland/archive/193bef6e20ab814db624b01d4bdd0c7160aa9838.tar.gz";
        sha256 = "1dsncs30252lak5sp8mjs88g3kjhyc1ngwsk30rwy9x1i3mr3z3s";
      }
    }/overlay.nix");

  # [01.01.2023]
  # Latest release dates from 12.12.2020 and is broken. Master branch seems fixed but ain't pushed to a new release.
  # mopidySoundCloudOverlay = self: super: {
  #   mopidy-soundcloud = super.mopidy-soundcloud.overrideAttrs (attr: {
  #     src = fetchTarball {
  #       url =
  #         "https://github.com/mopidy/mopidy-soundcloud/archive/c77fdfd128d7e8a9c9040dadd51dd98d36346608.tar.gz";
  #       sha256 = "0lcychifdviyj8a9ci3snavh4wfzsd15crbyrqa4djrg0g5x7wk9";
  #     };
  #     propagatedBuildInputs = attr.propagatedBuildInputs
  #       ++ [ super.python310Packages.beautifulsoup4 ];
  #   });
  # };
}
