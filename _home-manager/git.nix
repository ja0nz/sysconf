/* #+TITLE: Git - the version control system /w extras
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
    delta.enable =
      true; # delta syntax highlighter. See https://github.com/dandavison/delta.
    userName = "ja0nz"; # TODO Set your credentials
    userEmail = "mail@ja.nz"; # TODO Set your credentials
    ignores = [ "*~" ];
    signing = {
      key = "8B7845E28117C874"; # TODO Set default signing key
      signByDefault = true;
    };
    extraConfig = {
      core = {
        filemode = false;
        pager = "delta --line-numbers --dark";
        whitespace = "fix,tab-in-indent";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  home.packages = with pkgs;
    [
      git-extras # GIT utilities -- repo summary, repl, changelog population
    ];
}
