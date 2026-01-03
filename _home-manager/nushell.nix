/*
  #+TITLE: Nushell - a modern shell written in Rust w/ starship
  #+FILETAGS: :shell:development:

  * Optional configuration
   Some aliases are preset. This is of course a non breaking setting.
   You may add/alter them to your liking.
*/
{ config, pkgs, ... }:

let
  inherit (config) _configInUse;
in

{
  programs.nushell = {
    enable = true;

    extraEnv = ''
      $env.ENV_CONVERSIONS = {
        "PATH": {
            from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
            to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
      }
    '';

    extraConfig = ''
      $env.config = {
        show_banner: false
        edit_mode: emacs
        table: {
          mode: rounded
          index_mode: always
        }

      keybindings: [
          {
            name: mcfly_history
            modifier: control
            keycode: char_r
            mode: [emacs, vi_insert, vi_normal]
            event: { send: executehostcommand, cmd: "mcfly search" }
          }
          {
            name: fzf_history
            modifier: alt
            keycode: char_r
            mode: [emacs, vi_insert, vi_normal]
            event: { send: executehostcommand, cmd: "commandline edit --insert (history | get command | reverse | uniq | str join (char nl) | fzf --height 40% --layout reverse --border)" }
          }
        ]
      }

      # Your Custom Tree Command
      # Usage: `tree` or `tree ~/Downloads`
      def tree [path: string = "."] {
          fd . $path | as-tree
      }

      # A quick way to find a file and open it in your editor (Helix/Zed/Nvim)
      def ff [] {
          let file = (fd --type f | fzf --preview 'bat --color=always {}')
          if ($file | is-not-empty) {
              # Change 'hx' to your preferred editor (zed, nvim, etc)
              hx $file
          }
      }
    '';

    shellAliases = {
      # --- TODO Special sysconf/nixOS related commands
      "nixos:updateALL" = "do { cd ${toString ../.}; ${pkgs.npins}/bin/npins update }";
      "nixos:switch" = "sudo nixos-rebuild switch -f ${toString _configInUse}";
      "nixos:boot" = "sudo nixos-rebuild boot -f ${toString _configInUse}";
      "nixos:clean" = "sudo nix-collect-garbage -d";
      nix-stray-roots = "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'";
      # --- TODO General purpose
      curl = "curlie"; # net
      df = "duf"; # disk free
      dig = "doggo"; # DNS lookup
      groups = "id (whoami)";
      http = "xh"; # net
      network = "sudo bandwhich"; # net
      ping = "gping";
      rg = "rg --hidden --glob '!.git'"; # find
      vim = "hx";
      lscert = "ssh-keygen -L -f";
      run = "just";
      nix-shell = "nix-shell --command nu";
    };
  };
}
