{ config, pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users.root = {
      shell = pkgs.fish;
      hashedPassword =
        "$6$rBfbbdF/ghJdJo$cn/Hhzve2Lx5xmQR3p81mM.oBZ3PSyDaiUR1CfNZdBn839EFbQWqbLD73tnQCOag8ruDTgxvmwEFMTavwTC.r.";
    };
    users.me = {
      shell = pkgs.fish;
      isNormalUser = true;
      home = "/home/me";
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];
      uid = 1000;
      hashedPassword =
        "$6$rBfbbdF/ghJdJo$cn/Hhzve2Lx5xmQR3p81mM.oBZ3PSyDaiUR1CfNZdBn839EFbQWqbLD73tnQCOag8ruDTgxvmwEFMTavwTC.r.";
    };
  };
}
