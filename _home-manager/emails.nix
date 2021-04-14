{ config, ... }:

{
  accounts.email.accounts = {
    "mail@ja.nz" = rec {
      primary = true;
      address = "mail@ja.nz";
      userName = address;
      realName = "Ja0nz";
      passwordCommand = "gpg2 -q --for-your-eyes-only --no-tty -d ${config._secret}/mbsyncpass.gpg";
      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        extraConfig.account.AuthMechs = "Plain";
      };
      imap = {
        host = "imap.purelymail.com";
        tls.enable = true;
      };
#      notmuch.enable = true;
    };
  };

  programs.mbsync.enable = true;
#  programs.notmuch.enable = true;
}
