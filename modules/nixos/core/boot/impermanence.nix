{
  lib,
  config,
  ...
}: let
  cfg = config.core.boot.impermanence;
in {
  options.core.boot.impermanence = let
    mkOption = description:
      lib.mkOption {
        inherit description;
        type = with lib.types; listOf (oneOf [str (attrsOf str)]);
        default = [];
      };
  in {
    directories = mkOption "List of directories to be persisted";

    files = mkOption "List of files to be persisted";

    users = {
      directories = mkOption "List of directories to be persisted";

      files = mkOption "List of files to be persisted";
    };
  };

  config = lib.mkIf config.core.boot.enable {
    boot.initrd.systemd = {
      enable = true;
      services = {
        reset-disk = {
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

            btrfs subvolume list -o /mnt/home
            btrfs subvolume list -o /mnt/home |
            cut -f9 -d' ' |
            while read subvolume; do
              echo "deleting /$subvolume subvolume..."
              btrfs subvolume delete "/mnt/$subvolume"
            done &&
            echo "deleting /home subvolume..." &&
            btrfs subvolume delete /mnt/home
            echo "restoring blank /home subvolume..."
            btrfs subvolume snapshot /mnt/home-blank /mnt/home
            umount /mnt
          '';
        };
      };
    };

    fileSystems."/persist".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;

    environment = {
      persistence."/persist" = {
        enable = true;

        hideMounts = true;

        directories =
          [
            "/var/log"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
          ]
          ++ cfg.directories;

        files =
          [
            "/etc/machine-id"
          ]
          ++ cfg.files;

        users =
          lib.listToAttrs
          (
            map (user: {
              inherit (user) name;

              value = {
                inherit (cfg.users) directories files;
              };
            })
            config.core.suites.users.users
          );
      };
    };

    programs.fuse.userAllowOther = true;
  };
}
