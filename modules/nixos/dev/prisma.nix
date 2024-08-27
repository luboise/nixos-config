{
  config,
  lib,
  pkgs-stable,
  environment,
  ...
}: {
  environment.systemPackages = with pkgs-stable; [
    # For Prisma:
    nodePackages_latest.pnpm
    nodePackages_latest.vercel
    nodePackages_latest.prisma
    openssl
    nodejs
  ];

  environment.sessionVariables = {
    # Prisma:
    PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs-stable.prisma-engines}/lib/libquery_engine.node";
    PRISMA_QUERY_ENGINE_BINARY = "${pkgs-stable.prisma-engines}/bin/query-engine";
    PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs-stable.prisma-engines}/bin/schema-engine";
  };
}
