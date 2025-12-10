{ pkgs, ... }:

let
  enc =
    pkgs.runCommand "encryptAll-script"
      {
        src = ./devenv.encrypt.sh;
      }
      ''
        mkdir -p $out
        cp "$src" $out/devenv.encrypt.sh
        chmod +x "$out/devenv.encrypt.sh"
      '';
in
{

  enterShell = ''
    export SOPS_AGE_KEY_FILE="$HOME/.gnupg/age/sysconf.txt"
  '';

  packages = with pkgs; [
    git
    sops # Mozilla sops (Secrets OPerationS) is an editor of encrypted files
    age # Modern encryption tool with small explicit keys
    manix # A Fast Documentation Searcher for Nix
    npins # Simple and convenient dependency pinning for Nix
  ];

  git-hooks.hooks = {
    # format *.nix
    nixfmt-rfc-style.enable = true;

    encrypt-sops = {
      enable = true;
      name = "Encrypt SOPS files if modified";
      entry = "${enc}/devenv.encrypt.sh";
      files = "\\.sops$";
      types = [ "text" ];
      excludes = [ ];
      language = "system";
      pass_filenames = false;
    };
  };

  # https://devenv.sh/scripts/
  scripts = {
    encrypt.exec = ''sops --encrypt "$1" > "$1.sops"'';
    encryptAll.exec = "${enc}/devenv.encrypt.sh";
    decryptAll.exec = ./devenv.decrypt.sh;
  };

  languages.nix.enable = true;
}
