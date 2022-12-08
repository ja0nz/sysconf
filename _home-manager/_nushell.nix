/* #+TITLE: Nushell - a modern shell written in Rust w/ starship
   #+FILETAGS: :shell:development:

   --CURRENTLY ON HOLD--
   Currently, 01.12.2021, does not play with (nix-)direnv
   https://github.com/nushell/nushell/issues/2549

   * Optional configuration
    Some aliases are preset. This is of course a non breaking setting.
    You may add/alter them to your liking.
*/
{ pkgs, lib, ... }:

{
  programs.nushell = {
    enable = true;
    settings = {
      startup = [
        "# Sway"
        "if ($nu.env | select DISPLAY | empty?) { exec systemd-cat '-t sway' sway } { }"
        "# Starship"
        "mkdir ~/.cache/starship"
        "starship init nu | save ~/.cache/starship/init.nu"
        "source ~/.cache/starship/init.nu"
        "# Zoxide"
        "zoxide init nushell --hook prompt | save ~/.zoxide.nu"
        "source ~/.zoxide.nu"
        "# Aliases"
        "alias groups = id (whoami)"
        "alias rg = rg --hidden --glob '!.git'"
        "alias tree = tree -a -I 'node_modules|.git|.yarn'"
        "alias vim = nvim"
        "alias nix-stray-roots = nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'"
      ];
      prompt = "starship_prompt";
      edit_mode = "emacs";
      pivot_mode = "auto";
      skip_welcome_message = true;
    };
  };
}
