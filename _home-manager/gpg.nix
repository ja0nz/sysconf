# gpg -K --with-keygrip --keyid-format LONG
{ ... }:

{
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "8B7845E28117C874";
      # behavior
      no-emit-version = true;
      no-comments = true;
      keyid-format = "0xlong";
      with-fingerprint = true;
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      use-agent = true;
      # keyserver
      keyserver = "hkps://keys.openpgp.org/";
      keyserver-options = "no-honor-keyserver-url include-revoked";
      # algorithm and ciphers
      personal-cipher-preferences = "AES256 AES192 AES CAST5";
      personal-digest-preferences = "SHA512 SHA384 SHA256 SHA224";
      cert-digest-algo = "SHA512";
      default-preference-list ="SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
    };
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "D937A7A38C77F36C88A0A8CA49E3DECFBD704FCC" ];
  };
}
