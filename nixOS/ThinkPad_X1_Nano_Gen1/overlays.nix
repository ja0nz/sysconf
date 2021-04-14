{
  #  emacsOverlay = import <emacs>;

  nixmacsOverlay = self: super: {
    #    nixmacs = (self.pkgs.callPackage (/home/alex/nixmacs) {
    #      configurationFile = /home/alex/dotfiles/nixmacsConf.nix;
    #    });
    nixmacsrpi = let
      src = builtins.fetchTarball {
        url = "https://github.com/alexarice/nixmacs/archive/master.tar.gz";
      };
    in self.pkgs.callPackage src {
      configurationFile = /home/alex/dotfiles/nixmacs-conf-rpi.nix;
    };
  };

  fmt6overlay = self: super: { fmt_6 = super.fmt; };

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

  myWaylandOverlay = import <nixpkgs-wayland>;

  discordOverlay = self: super: {
    discord = (import <master> { config = { allowUnfree = true; }; }).discord;
  };

  agda-master = self: super: {
    haskellPackages = super.haskellPackages.override {
      overrides = hpNew: hpOld: rec {
        Agda = (import <master> { }).haskellPackages.Agda;
      };
    };
  };
}
