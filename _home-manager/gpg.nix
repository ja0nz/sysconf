/*
  #+TITLE: GnuPG - GNU Privacy Guard + Agent
  #+FILETAGS: :encrypt:auth:ssh:

  * Mandatory configuration
   Set up GPG and insert default key value.
   Get keys and keygrip by: ~gpg -K --with-keygrip --keyid-format LONG~
   Look out for [S] for signing key

  * Optional configuration
  ** Change GPG Settings
    The settings section following the Riseup OpenGPG Best Practices
    https://github.com/ioerror/duraconf/blob/master/configs/gnupg/gpg.conf

  ** Use GPG Agent
    You can manage your ssh authentication(s) with GPG! Except for
    ssh certificates this works pretty well.

    *One word of warning for Emacs/magit users:*
    Emacs server will start earlier than GPG and consequently miss
    the later set SSH_AUTH_SOCK variable. Magit won't work.
    You may either change the startup order or "hardwire" the env variable
    in your bash/fish/doomemacs config.
*/
{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "5A8F0894614456ED"; # TODO Insert default sign key
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
      default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
    };
  };

  # Optional: if you want to use GPG for SSH authentication
  services.gpg-agent = {
    enable = true;
    noAllowExternalCache = true;
    pinentry.package = pkgs.pinentry-gnome3;
    defaultCacheTtl = 6000;
    enableSshSupport = true;
    sshKeys = [
      "D937A7A38C77F36C88A0A8CA49E3DECFBD704FCC"
    ]; # TODO Insert keygrip(s) of auth key(s)
  };
}
