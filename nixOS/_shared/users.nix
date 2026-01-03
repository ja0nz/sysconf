/*
  #+TITLE: Users
  Defines users und home environment

  * Optional configuration
   Generate a hashedPassword:
   ~mkpasswd -m sha-512~
*/
{
  lib,
  pkgs,
  config,
  sources,
  ...
}:

let
  inherit (config) _configInUse _monoFont _emojiFont;
  packagePath = _configInUse + /packages.nix;
  overlayPath = _configInUse + /overlays.nix;
  mainUser = "me";
in
{
  imports = [
    (import "${sources.home-manager}/nixos")
  ];
  # Login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd $SHELL";
      };
      # AutoLogin the main users
      initial_session = {
        user = mainUser;
        command = "${pkgs.niri}/bin/niri-session";
        #command = "sway";
      };
    };
  };

  # Disable useradd/groupadd
  users.mutableUsers = false;

  users.users = {
    root = {
      shell = pkgs.fish;
      hashedPassword = "$6$rBfbbdF/ghJdJo$cn/Hhzve2Lx5xmQR3p81mM.oBZ3PSyDaiUR1CfNZdBn839EFbQWqbLD73tnQCOag8ruDTgxvmwEFMTavwTC.r.";
    };
    ${mainUser} = {
      shell = pkgs.nushell;
      isNormalUser = true;
      home = "/home/${mainUser}";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "libvirtd"
      ];
      uid = 1000;
      hashedPassword = "$6$rBfbbdF/ghJdJo$cn/Hhzve2Lx5xmQR3p81mM.oBZ3PSyDaiUR1CfNZdBn839EFbQWqbLD73tnQCOag8ruDTgxvmwEFMTavwTC.r.";
    };
  };

  home-manager.extraSpecialArgs = { inherit sources; };
  home-manager.users = {
    ${mainUser} =
      { ... }:
      {

        imports = [ packagePath ];
        config = {

          inherit _configInUse _monoFont _emojiFont;

          nixpkgs.config = {
            #allowBroken = true;
            allowUnfree = true;
            #allowUnsupportedSystem = true;
            #oraclejdk.accept_license = true;
          };

          nixpkgs.overlays = builtins.attrValues (
            import overlayPath {
              inherit sources;
            }
          );
          #_module.args.setEnvironment = config.system.build.setEnvironment;
          home = {
            stateVersion = config.system.stateVersion;
            shell = {
              enableFishIntegration = true;
              enableNushellIntegration = true;
            };
          };
        };

        # Global options
        options = with lib; {
          _configInUse = mkOption { type = types.path; };
          _monoFont = mkOption { type = types.attrs; };
          _emojiFont = mkOption { type = types.attrs; };
        };
      };
  };
}
