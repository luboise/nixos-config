{
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  options.mysql.enable = mkEnableOption "MySQL Service";

  config = mkIf config.mysql.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      replication.masterPort = 3306;
    };
  };
}
