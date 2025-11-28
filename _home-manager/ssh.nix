/*
  #+TITLE: SSH - Secure SHell
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
{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        serverAliveInterval = 0; # TODO if long running ssh sessions accross reboots, etc
        serverAliveCountMax = 3;
        addKeysToAgent = "no";
        hashKnownHosts = false; # TODO might set to true for more security
        forwardAgent = false;
        compression = false;
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlMaster = "auto"; # reuse connections
        controlPersist = "15m"; # reuse timeout
        userKnownHostsFile = toString ../_secret/ssh/known_hosts;
      };
      petelerFamily = {
        host = "pf"; # Just a abbrevation ~ssh pf~
        hostname = "knock-knock.peteler.family";
        port = 50022;
        user = "opc";
        identitiesOnly = true;
        identityFile = "${../_secret}/ssh/peteler-family-client";
      };
      "github.com" = {
        user = "git";
      };
    };
  };
}
