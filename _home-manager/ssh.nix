/* #+TITLE: SSH - Secure SHell
   #+FILETAGS: :shell:
   This config uses *ssh identities* and persistent connections via
   control persist. Note that while I typically use *GPG for managing
   my SSH connections this is purely optional
   Handle with care: This section is highly subjective.

   * Mandatory configuration
    Obviously, get your identities right (matchBlocks)

   * Optional configuration
    Make sure your hosts file is secured if you commit it like below
*/
{ config, ... }:

let inherit (config) _secret _repoRoot;
in {
  programs.ssh = {
    enable = true;
    userKnownHostsFile = builtins.toString _repoRoot
      + "/_secret/ssh/known_hosts"; # TODO Secure your known_hosts
    controlMaster = "auto";
    controlPersist = "15m";
    matchBlocks = {
      "peteler.family" = {
        host = "pf"; # Just a abbrevation ~ssh pf~
        hostname = "peteler.family";
        user = "root";
        identitiesOnly = true;
        identityFile = "${_secret}/ssh/ssh-peteler-family";
      };
      "git.peteler.family" = {
        user = "git";
        port = 2222;
        checkHostIP = false;
      };
      "github.com" = { user = "git"; };
    };
  };
}
