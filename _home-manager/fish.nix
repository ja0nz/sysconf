/* #+TITLE: Fish - a friendly interactive shell
   #+FILETAGS: :shell:development:

   * Mandatory configuration
    Take a look at the shell aliases! You may not be able to use
    ls, cat, find, etc. if you don't install it's dependencies too.

   * Optional configuration
    Some aliases come are preset. This is of course a non breaking setting.
    You may add/alter them to your liking.
*/
{ config, pkgs, ... }:

let inherit (config) _repoRoot;
in {
  home.sessionVariables = {
    # EDITOR = "emacsclient -c"; <-- set by services.emacs directly
    # BROWSER = "chromium"; <-- set in mimeapps.list instead
  };

  home.sessionPath = [
    # "$HOME/.yarn/bin"
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      # --- TODO Special sysconf/nixOS related commands
      "nixos:updateALL" = "sudo nix-channel --update; cd ${
          toString _repoRoot
        } && ${pkgs.niv}/bin/niv update; cd -";
      "nixos:switch" = "sudo nixos-rebuild switch";
      "nixos:boot" = "sudo nixos-rebuild boot";
      "nixos:clean" = "sudo nix-collect-garbage -d";
      nix-stray-roots =
        "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'";
      # --- TODO General purpose
      cat = "bat";
      curl = "curlie"; # net
      df = "duf"; # disk free
      dig = "doggo"; # DNS lookup
      du = "dust"; # file space usage
      find = "fd"; # find
      groups = "id (whoami)";
      http = "xh"; # net
      network = "sudo bandwhich"; # net
      ping = "gping";
      ps = "procs"; # process status
      rg = "rg --hidden --glob '!.git'"; # find
      vim = "hx";
      lscert = "ssh-keygen -L -f";
      run = "just";
      r = "rip"; # rm with safety
      music = "ncmpcpp";
      # Fish nix-shell
      nix-shell = "nix-shell --command fish";
      # ls, ll, la, lt, lla -> set by lsd
    };
    functions = {
      tree = "fd . $argv | as-tree";
      bind_enter = ''
        set -l lastline $history[1]
        set -l cmdline (commandline)
        if test -z (string trim "$cmdline")
            commandline -r $lastline
            commandline -f execute
        else
            commandline -f execute
        end
      '';
    };
    interactiveShellInit = ''
      # Bind mcfly interactively
      bind \cr __mcfly-history-widget
      bind \er fzf-history-widget
      bind \r bind_enter
    '';
  };

  # ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  # home.packages = with pkgs;
  #   [
  #     any-nix-shell # fish and zsh support for nix-shell
  #   ];
}
