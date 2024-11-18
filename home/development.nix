{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    nodejs_22
    nodePackages_latest.pnpm
    rustup

    prisma
  ];

  home.sessionVariables = {
    PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
    PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
    PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
  };
}
