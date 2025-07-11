/*
  #+TITLE: Syncthing - Open Source Continuous File Synchronization
  #+FILETAGS: :networking:services:

  * Optional configuration
  Increase UDP receive buffer size
  https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size#non-bsd
*/
{ ... }:

{
  services.syncthing = {
    enable = true;
  };
}
