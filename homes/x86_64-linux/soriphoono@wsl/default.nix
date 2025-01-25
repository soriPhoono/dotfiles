{lib, ...}: {
  imports = [
    ../soriphoono/default.nix
  ];

  noir.enable = lib.mkForce false;
}
