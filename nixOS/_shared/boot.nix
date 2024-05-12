/* #+TITLE: Boot loader
   Settings concerned the boot process
*/
{ ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "max";
    efi.canTouchEfiVariables = true;
    # supportedFilesystems = [ "ntfs" ];
  };
  boot.kernel.sysctl = { "net.core.rmem_max" = 2500000; };
}
