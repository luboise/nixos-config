{
  pkgs-stable,
  lib,
  config,
  ...
}:
with lib; let
  mkPrismaDbOption = {
    defaultDBName,
    defaultUserName,
    defaultUserPassword,
  }: {
    enable = mkEnableOption "Enable the ${defaultDBName} database.";
    db = {
      name = mkOption {
        type = types.str;
        default = defaultDBName;
      };

      user = mkOption {
        type = types.str;
        default = defaultUserName;
      };

      password = mkOption {
        type = types.str;
        default = defaultUserPassword;
      };
    };
  };
in {
  options.dev.prisma = {
    enable = mkEnableOption "Enable the Prisma TypeScript schema library.";
    databases = {
      open-magnate = mkPrismaDbOption {
        defaultDBName = "open_magnate_dev";
        defaultUserName = "prisma";
        defaultUserPassword = "password";
      };
    };
  };

  config = mkIf config.dev.prisma.enable {
    # Ensure every user is created
    #services.mysql.ensureUsers = mkIf config.services.mysql.enable (
    #mapAttrsToList (dbName: dbConfig: {
    #name = dbConfig.db.user;
    #ensurePermissions = {
    #"${dbConfig.db.name}.*" = "ALL PRIVILEGES";
    #};
    #})
    ## Filter the configs to only the enabled ones
    #(filterAttrs (_: dbConfig: dbConfig.enable) config.dev.prisma.databases)
    #);

    services.mysql.ensureDatabases = mkIf config.services.mysql.enable (
      mapAttrsToList (
        # Get the db that needs to be created out of each config
        dbName: dbConfig:
          dbConfig.db.name
      )
      (filterAttrs (_: dbConfig: dbConfig.enable) config.dev.prisma.databases)
    );

    #home.activation.ensure-mysql-databases = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #${lib.getBinDir}/sh -c '${concatStringsSep "\n" (
    #mapAttrsToList (
    #dbName: dbConfig:
    #ensureDatabaseExists dbConfig.database dbConfig.user dbConfig.password
    #)
    #config.dev.prisma.databases
    #)}'
    #'';

    environment.systemPackages = with pkgs-stable; [
      # For Prisma:
      nodePackages_latest.pnpm
      nodePackages_latest.vercel
      nodePackages_latest.prisma
      openssl
      nodejs
    ];

    environment.sessionVariables = with pkgs-stable; {
      # Prisma:
      PRISMA_QUERY_ENGINE_LIBRARY = "${prisma-engines}/lib/libquery_engine.node";
      PRISMA_QUERY_ENGINE_BINARY = "${prisma-engines}/bin/query-engine";
      PRISMA_SCHEMA_ENGINE_BINARY = "${prisma-engines}/bin/schema-engine";
    };
  };
}
