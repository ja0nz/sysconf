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
    console = {
      font = "Lat2-Terminus16";
      # TODO You may not want to use neo2 keyboard
      keyMap = "neo";
    };

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
      autoOptimiseStore = true;
      trustedUsers = [ "@wheel" ];
    };
  };
}
