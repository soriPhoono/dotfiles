{lib, ...}: {
  core.secrets.enable = lib.mkForce false;
}
