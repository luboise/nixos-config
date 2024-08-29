{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./hyprland-config.nix];

  config = lib.mkIf (config.systemOptions.windowManager == "hyprland") {
    programs.hyprland.enable = true;

    environment.systemPackages = [
      pkgs.kitty
    ];
    # services.displayManager.defaultSession = "plasma";
  };
}
