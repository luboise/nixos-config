{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.nvidia;
in {
  options = {
    nvidia.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Proprietary Nvidia Drivers";
    };
  };

  config = mkIf cfg.enable {
    # Nvidia setup
    hardware = {
      graphics.enable = true;
    };

    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;

      modesetting.enable = true;
      powerManagement.enable = false;
      # powerManagement.finegrained = true;
      open = false;

      # Settings app
      nvidiaSettings = true;
    };
  };
}
