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

  home.packages = with pkgs; [
    gitAndTools.git-extras # GIT utilities -- repo summary, repl, changelog population
    gitAndTools.delta # A syntax-highlighting pager for git
    git-secret # A bash-tool to store your private data inside a git repository
  ];
}
