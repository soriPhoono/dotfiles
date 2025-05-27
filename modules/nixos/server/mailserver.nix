{
  lib,
  config,
  ...
}: {
  sops.secrets."server/smtp_password" = {
    owner = "nextcloud";
    group = "users";
  };

  programs.msmtp = let
    adminEmail = (lib.findFirst (user: user.admin) null config.core.users).email;
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
}
