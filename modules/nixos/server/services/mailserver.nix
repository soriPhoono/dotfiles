{
  lib,
  config,
  ...
}: let
  cfg = config.server.mailserver;
in {
  options.server.mailserver.enable = lib.mkEnableOption "Enable mailserver interface";

  config = lib.mkIf cfg.enable {
    sops.secrets."server/smtp_password" = {
      owner = "nextcloud";
    };

    programs.msmtp = let
      adminEmail = (lib.findFirst (user: user.admin) null (builtins.attrValues config.core.users)).email;
    in {
      enable = true;
      accounts.default = {
        auth = true;
        tls = true;
        tls_starttls = false;
        host = "smtp.gmail.com";
        from = adminEmail;
        user = adminEmail;
        passwordeval = "cat ${config.sops.secrets."server/smtp_password".path}";
      };
    };
  };
}
