/*
gpg -K --with-keygrip --keyid-format LONG
*/
{ ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [
      "D937A7A38C77F36C88A0A8CA49E3DECFBD704FCC"
    ];
  };
}
