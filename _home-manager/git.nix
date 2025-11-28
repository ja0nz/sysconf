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
{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "ja0nz"; # TODO Set your credentials
      user.email = "git@ja.nz"; # TODO Set your credentials
      core = {
        filemode = false;
        whitespace = "fix,tab-in-indent";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    ignores = [ "*~" ];
    signing = {
      key = "5A8F0894614456ED"; # TODO Set default signing key
      signByDefault = true;
    };
  };
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
