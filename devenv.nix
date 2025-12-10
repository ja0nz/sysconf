{ pkgs, ... }:

{
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
      entry = "encryptAll";
      files = "\\.sops$";
      types = [ "text" ];
      excludes = [ ];
      language = "system";
      pass_filenames = false;
    };
  };

  # https://devenv.sh/scripts/
  scripts = {
    encryptAll.exec = ./devenv.encrypt.sh;
    decryptAll.exec = ./devenv.decrypt.sh;
  };

  languages.nix.enable = true;
}
