{
  description = "Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #master.url = "github:nixos/nixpkgs";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, # master,
    nixpkgs-wayland, home-manager }:
    let overlays = [ ];
    in {
      nixosConfigurations = {
        nixos-nano = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./common.nix
            ./users.nix
            ./home.nix
            ./overlays.nix
            ./hardware/laptop.nix
            ./cachix.nix
            home-manager.nixosModules.home-manager
            ({ ... }: {
              nixpkgs.overlays = overlays;

              networking.hostName = "nixos-nano"; # Define your hostname.

              hardware = { cpu.intel.updateMicrocode = true; };

              services = {
                upower.enable = true;

                tlp.enable = true;
                logind.lidSwitch = "ignore";
              };
              system.configurationRevision =
                nixpkgs.lib.mkIf (self ? rev) self.rev;
            })
          ];
        };
      };
    };
}
