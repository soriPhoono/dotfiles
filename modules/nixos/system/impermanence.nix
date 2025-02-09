{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  programs.fuse.userAllowOther = true;

  fileSystems."/persist".neededForBoot = true;

  environment.persistence."/persist" = {
    enable = true;

    hideMounts = true;

    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/tailscale"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"

      "/etc/NetworkManager/system-connections"
    ];

    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
