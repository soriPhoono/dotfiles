{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  sops = {
    secrets.searx_secret = {};
    templates.searx_secrets.content = ''
      SEARX_SECRET_KEY=${config.sops.placeholder.searx_secret}
    '';
  };

  services = {
    searx = {
      enable = true;
      redisCreateLocally = true;
      environmentFile = config.sops.templates.searx_secrets.path;
      settings = {
        server = {
          port = 8000;
          bind_address = "localhost";
          secret_key = "@SEARX_SECRET_KEY@";
        };
        search.formats = [
          "html"
          "json"
        ];
      };
    };
  };
}
