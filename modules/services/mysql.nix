{
  lib,
  config,
  pkgs-stable,
  ...
}:
with lib; {
  options.mysql.enable = mkEnableOption "MySQL Service";

  config = mkIf config.mysql.enable {
    services.mysql = {
      enable = true;
      package = pkgs-stable.mysql;
    };
  };
}
