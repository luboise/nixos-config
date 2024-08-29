{
  description = "Nixos config flake";

  # GET
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

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
    home-manager,
    ...
  } @ inputs: let
    args = {inherit inputs home-manager nixpkgs nixpkgs-stable;};
  in rec {
    nixosConfigurations = {
      laptop-aorus = import ./hosts/laptop-aorus args;
      home-desktop = import ./hosts/home-desktop args;
    };

    homeConfigurations = {
      home-desktop = nixosConfigurations.home-desktop.config.home-manager.users.lucasjr.home;
      laptop-aorus = nixosConfigurations.laptop-aorus.config.home-manager.users.lucasjr.home;
    };
  };
}
