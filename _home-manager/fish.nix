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
      cat = "bat";
      curl = "curlie"; # net
      cut = "choose"; # select
      df = "duf"; # disk free
      dig = "dog"; # DNS lookup
      du = "dust"; # file space usage
      find = "fd"; # find
      groups = "id (whoami)";
      http = "xh"; # net
      network = "sudo bandwhich"; # net
      # ping = "gping"; # TODO ONHOLD nixos
      ps = "procs"; # process status
      rg = "rg --hidden --glob '!.git'"; # find
      sed = "sd"; # select
      tree = "fd | as-tree"; # find
      vim = "nvim";
      # ls, ll, la, lt, lla -> set by lsd
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
