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
    shellAliases = {
      # --- TODO Special sysconf/nixOS related commands
      "nixos:updateALL" =
        "sudo nix-channel --update; cd ~/sysconf && rg fetchTarball -l | xargs -I@ direnv exec . update-nix-fetchgit @";
      "nixos:switch" = "sudo nixos-rebuild switch";
      "nixos:boot" = "sudo nixos-rebuild boot";
      "nixos:clean" = "sudo nix-collect-garbage -d";
      nix-stray-roots =
        "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'";
      # --- TODO General purpose
      cat = "bat";
      curl = "curlie"; # net
      df = "duf"; # disk free
      dig = "dog"; # DNS lookup
      du = "dust"; # file space usage
      find = "fd"; # find
      groups = "id (whoami)";
      http = "xh"; # net
      network = "sudo bandwhich"; # net
      ping = "gping";
      ps = "procs"; # process status
      rg = "rg --hidden --glob '!.git'"; # find
      vim = "nvim";
      lscert = "ssh-keygen -L -f";
      go = "just";
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
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
      ${pkgs.zoxide}/bin/zoxide init fish | source
      ${pkgs.starship}/bin/starship init fish | source
      # Bind mcfly interactively
      bind \cr __mcfly-history-widget
      bind \er fzf-history-widget
      bind \r bind_enter
    '';
  };

  home.packages = with pkgs;
    [
      any-nix-shell # fish and zsh support for nix-shell
    ];
}
