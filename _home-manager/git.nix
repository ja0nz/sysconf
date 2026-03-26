/*
  #+TITLE: Git - the version control system /w extras
  #+FILETAGS: :development:

  * Mandatory configuration
   You must set your git credentials.
   Short key: ~gpg --list-secret-keys --keyid-format LONG~
   Look out for [S] for signing key

  * Optional configuration
   This config uses https://github.com/dandavison/delta as git pager.
   You may like it or not.
*/
{ pkgs, config, ... }:

let
  user = "ja0nz";
  email = "git@ja.nz";
  signKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIb46mNzQBJQS7c5xKQWRYPOk3z5+q78bzPTVCC2PDVl";
in
{
  programs.git = {
    enable = true;
    settings = {
      user.name = user;
      user.email = email;
      core = {
        filemode = false;
        whitespace = "fix,tab-in-indent";
      };
      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    ignores = [ "*~" ];
    signing = {
      format = "ssh";
      key = signKey;
      signByDefault = true;
    };
  };

  # Create allowed_signers file for SSH signature verification
  # Add your own SSH public key(s) here
  home.file.".config/git/allowed_signers".text = ''
    ${email} namespaces="git" ${signKey} 
  '';

  programs.delta = {
    enable = true; # delta syntax highlighter. See https://github.com/dandavison/delta.
    enableGitIntegration = true;
    options = {
      features = "line-numbers";
      syntax-theme = "Dracula";
    };
  };

  home.packages = with pkgs; [
    git-extras # GIT utilities -- repo summary, repl, changelog population
  ];
}
