{ lib, config, pkgs, ... }:
let
  mailjanz = "mail@ja.nz";
in {
  accounts.email.accounts = {
    "mail@ja.nz" = rec {
      primary = true;
      address = mailjanz;
      userName = mailjanz;
      realName = "Ja0nz";
      passwordCommand =
        "gpg2 -q --for-your-eyes-only --no-tty -d ${config._secret}/mbsyncpass_maildir.gpg";
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
    };
  };

  home.file.".emacs.d/authinfo.gpg".source = "${config._secret}/authinfo_emacs.gpg";

  programs.mbsync = {
    enable = true;
    package = pkgs.isync;
  };
  home.packages = with pkgs; [
    mu # A collection of utilties for indexing and searching Maildirs
  ];
  home.activation.muInit = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mu info | grep ${mailjanz} || mu init --my-address=${mailjanz}
    # For multiple users;
    # mu info | grep ${mailjanz} && mu info | grep another@email \
    #   || mu init --my-address=${mailjanz} --my-address=another@email
  '';
}