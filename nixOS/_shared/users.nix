/* #+TITLE: Users
   #+FILETAGS: :sys:

   * Optional configuration
    Generate a hashedPassword:
    ~mkpasswd -m sha-512~
*/
{ config, pkgs, ... }:

{
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
      home = "/home/me";
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];
      uid = 1000;
      hashedPassword =
        "$6$rBfbbdF/ghJdJo$cn/Hhzve2Lx5xmQR3p81mM.oBZ3PSyDaiUR1CfNZdBn839EFbQWqbLD73tnQCOag8ruDTgxvmwEFMTavwTC.r.";
    };
  };
}
