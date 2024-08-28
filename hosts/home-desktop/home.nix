{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};

    useGlobalPkgs = true;
    useUserPackages = true;

    users = {
      "lucasjr" = import ../../modules/home-manager;
    };

    #    modules = [
    # Home Manager
    # inputs.home-manager.nixosModules.default
    #];
  };
}
