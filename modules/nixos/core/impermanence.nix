{inputs, ...}: {
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
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
  };
}
