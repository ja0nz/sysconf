/* #+TITLE: Enable virutalisation through libvirt
   Based on
   https://nixos.wiki/wiki/Virt-manager
   * Mandatory configuration
   You have to add user in the libvirtd group.
   users.users.<myuser>.extraGroups = [ "libvirtd" ];
*/
{ ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
}
