/* Optional requires:
   - GPG2 for password retrieval
*/
{ lib, config, pkgs, ... }:
let
  mailjanz = "mail@ja.nz";
  janpetelergmailcom = "jan.peteler@gmail.com";
  maildir = ".mail";
in {
  accounts.email = {
    maildirBasePath = maildir;
    accounts = {
      "mail@ja.nz" = {
        primary = true;
        flavor = "plain";
        address = mailjanz;
        userName = mailjanz;
        realName = "Ja0nz";
        passwordCommand =
          "gpg2 -q --for-your-eyes-only --no-tty -d ${config._secret}/mbsync_janz.gpg";
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
        };
        imap = {
          host = "imap.purelymail.com";
          tls.enable = true;
        };
      };
      "jan.peteler@gmail.com" = {
        flavor = "gmail.com";
        address = janpetelergmailcom;
        userName = janpetelergmailcom;
        realName = "Jan";
        passwordCommand =
          "gpg2 -q --for-your-eyes-only --no-tty -d ${config._secret}/mbsync_gmail.gpg";
        mbsync = {
          enable = true;
          extraConfig.account.PipelineDepth = 50;
          groups.gmail.channels = {
            inbox = {
              masterPattern = "INBOX";
              slavePattern = "INBOX";
              extraConfig = { Expunge = "Both"; };
            };
            trash = {
              masterPattern = "[Gmail]/Bin";
              slavePattern = "Trash";
              extraConfig = { Create = "Slave"; };
            };
            drafts = {
              masterPattern = "[Gmail]/Drafts";
              slavePattern = "Drafts";
              extraConfig = {
                Create = "Slave";
                Expunge = "Both";
              };
            };
            sent = {
              masterPattern = "[Gmail]/Sent Mail";
              slavePattern = "Sent";
              extraConfig = { Create = "Slave"; };
            };
            archive = {
              masterPattern = "[Gmail]/All Mail";
              slavePattern = "Archive";
              extraConfig = {
                Create = "Slave";
                Sync = "Push";
                Expunge = "Both";
              };
            };
          };
        };
        imap = {
          host = "imap.gmail.com";
          tls.enable = true;
        };
      };
    };
  };

  home.file.".authinfo.gpg".source = "${config._secret}/authinfo_emacs.gpg";

  programs.mbsync = {
    enable = true;
    package = pkgs.isync;
  };
  home.packages = with pkgs;
    [
      mu # A collection of utilties for indexing and searching Maildirs
    ];

  /* Init and index mu!
     .mail and .mail/.attachments are the default locations of Doom Emacs
  */
  home.activation.muInit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # For single user:
    # mu info | grep ${mailjanz} || mu init --maildir ${maildir} --my-address=${mailjanz}
    # For multiple users:
    mu info | grep ${mailjanz} && mu info | grep ${janpetelergmailcom} \
       || mu init --maildir ${maildir} --my-address=${mailjanz} --my-address=${janpetelergmailcom}
    mu index
    mkdir -p ${maildir}/.attachments
  '';
}
