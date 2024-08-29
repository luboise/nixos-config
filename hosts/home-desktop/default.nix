nixosConfigurations.home-desktop = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;

        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./hosts/home-desktop/configuration.nix
        # home-manager.nixosModules.home-manager
      ];
    };
