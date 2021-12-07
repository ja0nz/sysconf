/* #+TITLE: Nextcloud - Enable nextcloud client daemon
   #+FILETAGS: :networking:services:
*/
{ ... }:

{
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
