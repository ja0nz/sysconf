/* #+TITLE: Fish - a friendly interactive shell
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
    # BROWSER = "chromium"; <-- set in mimeapps.list instead
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
    shellAliases = {
      # --- TODO Special sysconf/nixOS related commands
      "nixos:updateALL" = ''
        cd ~/sysconf && rg fetchTarball -l | xargs -I@ update-nix-fetchgit @ \
        sudo nix-channel --update'';
      "nixos:switch" = "sudo nixos-rebuild switch";
      "nixos:boot" = "sudo nixos-rebuild boot";
      "nixos:clean" = "sudo nix-collect-garbage -d";
      nix-stray-roots =
        "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'";
      # --- TODO General purpose
      vim = "nvim";
      groups = "id (whoami)";
      rg = "rg --hidden --glob '!.git'";
      tree = "tree -a -I 'node_modules|.git|.yarn'";
      cat = "bat";
      find = "fd";
      du = "dust";
      ps = "procs";
      sed = "sd";
      banwhich = "sudo bandwhich";
      # ls = "exa"; -> set by exa
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
