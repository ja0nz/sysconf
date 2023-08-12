/* #+TITLE: Base configuration
   Just some minimal but sane defaults
*/
{ pkgs, ... }:

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
      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        # experimental-features = nix-command flakes
      '';
      settings.auto-optimise-store = true;
      settings.trusted-users = [ "@wheel" ];
    };
  };
}
