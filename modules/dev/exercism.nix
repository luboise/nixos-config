{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.exercism.enable = mkEnableOption "Enable exercism CLI";

  config = mkIf config.exercism.enable {
    environment.systemPackages = with pkgs; [
      exercism
    ];
  };
}
