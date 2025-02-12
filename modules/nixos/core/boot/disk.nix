{
  lib,
  config,
  ...
}: let
  cfg = config.core.boot.disk;
in {
  options.core.boot.disk = {
    device = lib.mkOption {
      type = lib.types.str;
      description = "The primary system drive";

      default = "/dev/nvme0n1";
    };
  };

  config = lib.mkIf config.core.boot.enable {
    disko.devices = let
      type = "btrfs";
      extraArgs = ["-L" "nixos" "-f"];
      subvolumes = {
        "/root" = {
          mountpoint = "/";
          mountOptions = [
            "subvol=root"
            "compress=zstd"
            "noatime"
          ];
        };
        "/home" = {
          mountpoint = "/home";
          mountOptions = [
            "subvol=home"
            "compress=zstd"
            "noatime"
          ];
        };
        "/persist" = {
          mountpoint = "/persist";
          mountOptions = [
            "subvol=persist"
            "compress=zstd"
            "noatime"
          ];
        };
        "/nix" = {
          mountpoint = "/nix";
          mountOptions = [
            "subvol=nix"
            "compress=zstd"
            "noatime"
          ];
        };
      };
    in {
      disk = {
        root = {
          inherit (cfg) device;
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                name = "ESP";
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["defaults"];
                };
              };
              root = {
                size = "100%";
                content = {
                  inherit type extraArgs subvolumes;

                  postCreateHook = ''
                    MNTPOINT=$(mktemp -d)
                    mount "/dev/disk/by-partlabel/disk-root-root" "$MNTPOINT" -o subvolid=5
                    trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
                    btrfs subvolume snapshot -r $MNTPOINT/root $MNTPOINT/root-blank
                  '';
                };
              };
            };
          };
        };
      };
    };
  };
}
