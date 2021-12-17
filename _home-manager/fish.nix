/* #+TITLE: Fish - a friendly interactive shell w/ bat
   #+FILETAGS: :shell:development:

   * Mandatory configuration
    Take a look at the shell aliases! You may not be able to use
    ls, cat, find, etc. if you don't install it's dependencies too.

   * Optional configuration
    Some aliases come are preset. This is of course a non breaking setting.
    You may add/alter them to your liking.
*/
{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    BROWSER = "chromium";
  };

  home.sessionPath = [
    # "$HOME/.yarn/bin"
  ];

  programs.fish = {
    enable = true;
    loginShellInit = ''
      if not set -q SWAYSTARTED
        if not set -q DISPLAY && test (tty) = /dev/tty1
          set -g SWAYSTARTED 1
          exec sway
        end
      end
    '';
    shellAliases = { # TODO Adapt aliases to your needs
      groups = "id (whoami)";
      rg = "rg --hidden --glob '!.git'";
      tree = "tree -a -I 'node_modules|.git|.yarn'";
      cat = "bat";
      find = "fd";
      du = "dust";
      ps = "procs";
      sed = "sd";
      # ls = "exa"; -> set by exa
      vim = "nvim";
      nix-stray-roots =
        "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'";
    };
    interactiveShellInit = ''
      any-nix-shell fish | source
      zoxide init fish | source
      starship init fish | source
    '';
  };

  home.packages = with pkgs;
    [
      any-nix-shell # fish and zsh support for nix-shell
    ];
}
