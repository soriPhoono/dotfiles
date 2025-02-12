{
  lib,
  config,
  ...
}: let
  cfg = config.core.boot.impermanence;
in {
  options.core.boot.impermanence = {
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of directories to be persisted";
    };

    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of files to be persisted";
    };
  };

  config = lib.mkIf config.core.boot.enable {
    boot.initrd.systemd = {
      enable = false;
      services.reset = {
        description = "reset root filesystem";

        wantedBy = ["initrd.target"];
        requires = ["dev-disk-by\\x2dlabel-nixos.device"];
        after = ["dev-disk-by\\x2dlabel-nixos.device"];
        before = ["sysroot.mount"];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir -p /mnt
          mount -o subvolid=5 -t btrfs /dev/disk/by-partlabel/disk-root-root /mnt
          btrfs subvolume list -o /mnt/root
          btrfs subvolume list -o /mnt/root |
          cut -f9 -d' ' |
          while read subvolume; do
            echo "deleting /$subvolume subvolume..."
            btrfs subvolume delete "/mnt/$subvolume"
          done &&
          echo "deleting /root subvolume..." &&
          btrfs subvolume delete /mnt/root
          echo "restoring blank /root subvolume..."
          btrfs subvolume snapshot /mnt/root-blank /mnt/root
          umount /mnt
        '';
      };
    };

    fileSystems."/persist".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;

    environment.persistence."/persist" = {
      enable = true;

      hideMounts = true;

      directories =
        [
          "/etc/nixos"

          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd"
        ]
        ++ cfg.directories;

      files = [
        "/etc/machine-id"
      ];
    };

    programs.fuse.userAllowOther = true;
  };
}
