{
  lib,
  config,
  ...
}: let 
  cfg = config.server.containers.linkwarden;
in with lib; {
  options.server.containers.linkwarden = {
    enable = mkEnableOption "Enable linkwarden bookmark manager";
  };

  config = mkIf cfg.enable {
    sops = {
      secrets = {
        "server/linkwarden/secret" = {};
      };
      templates."linkwarden.env".content = ''
        DATABASE_URL=postgresql://linkwarden:${config.sops.placeholder."server/postgresql/users/linkwarden_password"}@postgresql:5432/linkwarden
        NEXTAUTH_SECRET=${config.sops.placeholder."server/linkwarden/secret"}
        NEXTAUTH_URL=http://localhost:3000/api/v1/auth
      '';
    };

    virtualisation.oci-containers.containers = {
      meilisearch = {
        image = "getmeili/meilisearch:v1.12.8";

        environmentFiles = [
          config.sops.templates."linkwarden.env".path
        ];

        volumes = [
          "/mnt/data/meilisearch:/meili_data"
        ];
      };

      linkwarden = {
        image = "ghcr.io/linkwarden/linkwarden:latest";

        environmentFiles = [
          config.sops.templates."linkwarden.env".path
        ];

        volumes = [
          "/mnt/data/linkwarden/:/data/data/"
        ];

        networks = [
          "office_network"
        ];

        ports = [
          "3000:3000"
        ];
      };
    };
  };
}