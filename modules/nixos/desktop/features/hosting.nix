{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.hosting;
in with lib; {
  options.desktop.features.hosting = {
    enable = mkEnableOption "hosting features";

    provider = mkOption {
      type = with types; str;
      description = "The provider of your domain name for ddclient";
      example = "cloudflare";
    };

    domain = mkOption {
      type = with types; str;
      description = "Domain being hosted from this machine";
      example = "domain.xyz";
    };

    targets = mkOption {
      type = with types; listOf str;
      description = "Domains to synchronize to this machine";
      example = [
        "domain.xyz"
        "www.domain.xyz"
      ];
    };
  };

  # TODO: fix group assignment to be inline with users.nix
  config = mkIf cfg.enable {
    sops.secrets."desktop/hosting_password" = {};

    environment.systemPackages = with pkgs; [
      docker-compose
    ];

    virtualisation = {
      docker = {
        enable = true;
        autoPrune.enable = true;
        rootless.enable = true;
      };
    };

    services.ddclient = {
      enable = true;
      protocol = cfg.provider;
      zone = cfg.domain;
      passwordFile = config.sops.secrets."desktop/hosting_password".path;
      use = "web";
      extraConfig = "web='https://cloudflare.com/cdn-cgi/trace'";
      domains = cfg.targets;
    };

    users.extraUsers =
      builtins.mapAttrs (name: user: {
        extraGroups = [
          "docker"
        ];
      })
      (filterAttrs
        (name: content: content.admin)
        config.core.users);
  };
}
