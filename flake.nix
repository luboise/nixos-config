{
  description = "Nixos config flake";

  # GET
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-future.url = "github:nixos/nixpkgs/nixos-unstable-small";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager.url = "github:luboise/homemanager-config";
  };

  # PUT
  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-future,
    home-manager,
    ...
  } @ inputs: rec {
    nixosConfigurations = {
      home-pc = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs home-manager;
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-future = import nixpkgs-future {
            inherit system;
            config.allowUnfree = true;
          };
        };

        modules = [
          home-manager.nixosModules.home-manager
          ./home-pc/configuration.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.asad = import ./home-pc/home.nix;
          }
        ];
      };
    };

    homeConfigurations = {
      home-pc = nixosConfigurations.home-desktop.config.home-manager.users.asad.home;
    };
  };
}
