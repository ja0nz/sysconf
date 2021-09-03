/* #+TITLE: Users
   Defines users und home environment

   * Optional configuration
    Generate a hashedPassword:
    ~mkpasswd -m sha-512~
*/
{ lib, pkgs, config, ... }:

let
  inherit (config) _configInUse _repoRoot _monoFont;
  packagePath = _configInUse + /packages.nix;
  overlayPath = _configInUse + /overlays.nix;
  mainUser = "me";
in {
  imports = [ <home-manager/nixos> ];

  services = { getty.autologinUser = mainUser; };

  # Disable useradd/groupadd
  users.mutableUsers = false;
  users.users = {
    root = {
      shell = pkgs.fish;
      hashedPassword =
        "$6$rBfbbdF/ghJdJo$cn/Hhzve2Lx5xmQR3p81mM.oBZ3PSyDaiUR1CfNZdBn839EFbQWqbLD73tnQCOag8ruDTgxvmwEFMTavwTC.r.";
    };
    me = {
      shell = pkgs.fish;
      isNormalUser = true;
      home = "/home/${mainUser}";
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];
      uid = 1000;
      hashedPassword =
        "$6$rBfbbdF/ghJdJo$cn/Hhzve2Lx5xmQR3p81mM.oBZ3PSyDaiUR1CfNZdBn839EFbQWqbLD73tnQCOag8ruDTgxvmwEFMTavwTC.r.";
    };
  };

  home-manager.users.me = { ... }: {

    imports = [ packagePath ];
    config = {

      inherit _repoRoot _monoFont;
      _secret = ../../_secret;

      nixpkgs.config = {
        #allowBroken = true;
        allowUnfree = true;
        #allowUnsupportedSystem = true;
        #oraclejdk.accept_license = true;
      };

      nixpkgs.overlays = builtins.attrValues (import overlayPath);
      #_module.args.setEnvironment = config.system.build.setEnvironment;
      home.stateVersion = config.system.stateVersion;
    };

    # Global options
    options = with lib; {
      _repoRoot = mkOption { type = types.path; };
      _monoFont = mkOption { type = types.attrs; };
      _secret = mkOption { type = types.path; };
    };
  };
}
