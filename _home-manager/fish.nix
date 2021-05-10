/* #+TITLE: Fish - a friendly interactive shell w/ bat
   #+FILETAGS: :shell:development:

   * Optional configuration
    Some aliases come are preset. This is of course a non breaking setting.
    You may add/alter them to your liking.
*/
{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = { # TODO Adapt aliases to your needs
      groups = "id (whoami)";
      rg = "rg --hidden --glob '!.git'";
      cat = "bat";
      vim = "nvim";
      nix-stray-roots =
        "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'";
    };
    promptInit = "\n any-nix-shell fish --info-right | source\n";

    # Adding 'z' -> https://github.com/jethrokuan/z
    plugins = [{
      name = "z";
      src = pkgs.fetchFromGitHub {
        owner = "jethrokuan";
        repo = "z";
        rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
        sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
      };
    }];
  };

  # Enabled bat which is a sane 'cat' replacement
  programs.bat.enable = true;

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    BROWSER = "brave";
    #PATH = "$HOME/.yarn/bin:$PATH"; # Impure but harmless!
  };

  home.packages = with pkgs;
    [
      any-nix-shell # fish and zsh support for nix-shell
    ];

  # Setting a fish theme
  # Currently -> https://github.com/wyqydsyq/emoji-powerline
  xdg.configFile."fish/functions".source = pkgs.fetchFromGitHub {

    #   owner = "oh-my-fish";
    #   repo = "theme-agnoster";
    #   rev = "3a43a778676251c940fa11b21dbd6d311197624c";
    #   sha256 = "1qc6srdg8ar9k7p97yg2q0naqdd260wxkljf0r91gh2hidw583xa";
    owner = "wyqydsyq";
    repo = "emoji-powerline";
    rev = "eab03a3973c3c121433f5f3c588f833c34441fd5";
    sha256 = "0brz45wzmyfpl59dfvkh9ck216354lw5xlm96rdp2a10kv03ngqj";
  };
}
