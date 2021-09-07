/* #+TITLE: Enable virutalisation through libvirt
   Based on
   https://nixos.wiki/wiki/Virt-manager
*/
{ pkgs, ... }:

{
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];
  virtualisation.libvirtd.enable = true;
}
