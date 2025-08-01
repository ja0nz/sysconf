/*
  #+TITLE: Email Accounts w/ isync & mu
  #+FILETAGS: :user:

  This config hosts two examples of a normal/plain email account
  and a Gmail account which needs extra treatment.
  Handle with care: This section is highly subjective.

  * Mandatory configuration
   Set up your GPG keyfiles:
   ~gpg -e --default-recipient-self <filewithpassword>~
   You may use pass or bitwarden instead. Up to you.
*/
{ lib, pkgs, ... }:
let
  mailjanz = "mail@ja.nz";
  janpetelergmailcom = "jan.peteler@gmail.com";
  maildir = ".mail";
  passwordcmd = "${pkgs.sops}/bin/sops -d";
in
{
  accounts.email = {
    maildirBasePath = maildir;
    accounts = {
      # "mail@ja.nz" = {
      #   primary = true;
      #   flavor = "plain";
      #   address = mailjanz;
      #   userName = mailjanz;
      #   realName = "Ja0nz";
      #   passwordCommand = passwordcmd + "${../_secret}/mbsync_janz";
      #   mbsync = {
      #     enable = true;
      #     create = "maildir";
      #     expunge = "both";
      #   };
      #   imap = {
      #     host = "imap.purelymail.com";
      #     tls.enable = true;
      #   };
      # };
      "jan.peteler@gmail.com" = {
        primary = true;
        flavor = "gmail.com";
        address = janpetelergmailcom;
        userName = janpetelergmailcom;
        realName = "Jan";
        passwordCommand = passwordcmd + "${../_secret}/mbsync_gmail";
        mbsync = {
          enable = true;
          extraConfig.account.PipelineDepth = 50;
          groups.gmail.channels = {
            inbox = {
              farPattern = "INBOX";
              nearPattern = "INBOX";
              extraConfig = {
                Expunge = "both";
              };
            };
            trash = {
              farPattern = "[Gmail]/Bin";
              nearPattern = "Trash";
              extraConfig = {
                Create = "near";
              };
            };
            drafts = {
              farPattern = "[Gmail]/Drafts";
              nearPattern = "Drafts";
              extraConfig = {
                Create = "near";
                Expunge = "both";
              };
            };
            sent = {
              farPattern = "[Gmail]/Sent Mail";
              nearPattern = "Sent";
              extraConfig = {
                Create = "near";
              };
            };
            archive = {
              farPattern = "[Gmail]/All Mail";
              nearPattern = "Archive";
              extraConfig = {
                Create = "near";
                Sync = "push";
                Expunge = "both";
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

  home.file.".authinfo.gpg".source = "${../_secret}/authinfo_emacs.gpg";

  programs.mbsync = {
    enable = true;
    package = pkgs.isync; # Free IMAP and MailDir mailbox synchronizer
  };
  home.packages = with pkgs; [
    mu # A collection of utilties for indexing and searching Maildirs
  ];

  /*
    Init and index mu!
    .mail and .mail/.attachments are the default locations of Doom Emacs
  */
  home.activation.muInit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # For single user:
    mu info | grep ${janpetelergmailcom} || mu init --maildir ${maildir} --my-address=${janpetelergmailcom}

    # For multiple users:
    # mu info | grep ${mailjanz} && mu info | grep ${janpetelergmailcom} || \
    #   mu init --maildir ${maildir} \
    #     --my-address=${mailjanz} \
    #     --my-address=${janpetelergmailcom}

    mu index
    mkdir -p ${maildir}/.attachments
  '';
}
