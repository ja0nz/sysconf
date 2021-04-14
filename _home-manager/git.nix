{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "ja0nz";
    userEmail = "mail@ja.nz";
    ignores = [ "*~" ];
    signing = {
      key = "8117C874"; # Short key: gpg --list-secret-keys --keyid-format short
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
