/* #+TITLE: Enable virutalisation through libvirt
   Based on
   https://nixos.wiki/wiki/Virt-manager
   * Mandatory configuration
   You have to add user in the libvirtd group.
   users.users.<myuser>.extraGroups = [ "libvirtd" ];
*/
{ pkgs, ... }:

{
  programs.dconf.enable = true;
  #   environment.systemPackages = with pkgs; [ virt-manager ];
  #   virtualisation.libvirtd.enable = true;
}
