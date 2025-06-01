{
  lib,
  config,
  ...
}: let
  cfg = config.server.authelia;
in {
  systemd.services.authelia.after = ["lldap.service"];
}
