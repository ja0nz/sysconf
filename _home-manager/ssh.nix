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

let inherit (config) _repoRoot;
in {
  programs.ssh = {
    enable = true;
    # TODO Secure your known_hosts
    userKnownHostsFile = "${toString _repoRoot}/_secret/ssh/known_hosts";
    controlMaster = "auto";
    controlPersist = "15m";
    matchBlocks = {
      petelerFamily = {
        host = "pf"; # Just a abbrevation ~ssh pf~
        hostname = "knock-knock.peteler.family";
        port = 50022;
        user = "opc";
        identitiesOnly = true;
        identityFile = "${../_secret}/ssh/peteler-family-client";
      };
      "github.com" = { user = "git"; };
    };
  };
}
