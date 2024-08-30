{
  config,
  lib,
  pkgs-stable,
  environment,
  ...
}:
with lib; {
  options.godot.enable = mkEnableOption "Enable Godot Game Engine";

  config = mkIf config.godot.enable {
    environment.systemPackages = with pkgs-stable; [
      godot_4
    ];
  };
}
