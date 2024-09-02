/* #+TITLE: Zoxide - Post-modern modal text editor, with vim keybindings
   #+FILETAGS: :editor:
*/
{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    extraPackages = with pkgs; [
      # Markdown
      marksman
      markdown-oxide
      # Nix
      nil
      # Yaml
      yaml-language-server
      # Toml
      taplo
      # Bash
      bash-language-server
    ];
    settings = {
      theme = "dracula";
      editor = {
        shell = [ "fish" "-c" ];
        mouse = false;
        bufferline = "always";
        cursor-shape.insert = "bar";
      };
    };
  };
}
