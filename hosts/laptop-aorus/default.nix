{
  inputs,
  nixpkgs,
  nixpkgs-stable,
  home-manager,
  ...
}:
nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs home-manager;
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  modules = [
    home-manager.nixosModules.home-manager
    ../../modules
    {
      # User Defined Options
      systemOptions.windowManager = "plasma";

      system.stateVersion = "24.05"; # Did you read the comment?

      imports = [./hardware-configuration.nix];
    }
  ];
}
