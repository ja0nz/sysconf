{ config, ... }:

let inherit (config) _secret _repoRootStringPath;
in {
  programs.ssh = {
    enable = true;
    userKnownHostsFile = "${_repoRootStringPath}/_secret/ssh/known_hosts";
    controlMaster = "auto";
    controlPersist = "15m";
    matchBlocks = {
      "peteler.family" = {
        host = "pf";
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
