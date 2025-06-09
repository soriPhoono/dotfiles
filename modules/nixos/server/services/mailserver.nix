{
  lib,
  config,
  ...
}: let
  cfg = config.server.mailserver;
in {
  options.server.mailserver = with lib; {
    enable = mkEnableOption "Enable mailserver interface";
    host = mkOption {
      type = str;
      description = "The host fqdn of the stmp server to use";
      example = "smtp.gmail.com";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."server/smtp_password" = {
      owner = "nextcloud";
    };

    programs.msmtp = let
      adminEmail = (lib.findFirst (user: user.admin) null (builtins.attrValues config.core.users)).email;
    in {
      enable = true;
      accounts.default = {
        inherit (cfg) host;

        auth = true;
        tls = true;
        tls_starttls = false;
        from = adminEmail;
        user = adminEmail;
        passwordeval = "cat ${config.sops.secrets."server/smtp_password".path}";
      };
    };
  };
}
