/*
  #+TITLE: Base configuration
  Just some minimal but sane defaults
*/
{
  pkgs,
  config,
  sources,
  ...
}:

{
  config = {

    # Sudo
    security = {
      sudo.enable = true;
      sudo.extraConfig = "Defaults pwfeedback";
    };

    # Console settings
    console.font = "Lat2-Terminus16";

    # System packages
    environment = {
      systemPackages = with pkgs; [ git ];
      homeBinInPath = true; # PATH=~/bin:$PATH -> for adhoc binaries
    };

    # Nix settings
    nix = {
      channel.enable = false;
      nixPath = [ "nixpkgs=${sources.nixpkgs}" ];
      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        experimental-features = nix-command flakes
      '';
      settings.auto-optimise-store = true;
      settings.trusted-users = [ "@wheel" ];
    };
  };
}
