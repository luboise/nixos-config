{
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  programs.hyprland.enable = true;

  environment.systemPackages = [
    pkgs.kitty
  ];
  # services.displayManager.defaultSession = "plasma";
}
