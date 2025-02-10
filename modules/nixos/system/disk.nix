{
  lib,
  config,
  ...
}: let
  cfg = config.system.disk;
in {
  options.system.disk = {
    enable = lib.mkEnableOption "Enable disk configuration";

    hostId = lib.mkOption {
      type = lib.types.str;
      description = "The machine-id to use for the system's zfs pool";
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      inherit (cfg) hostId;
    };

    disko.devices = {
      disk = {
        main = {
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };
              zfs = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
      };
      zpool = {
        zroot = {
          type = "zpool";
          rootFsOptions = {
            acltype = "posixacl";
            atime = "off";
            compression = "lz4";
            mountpoint = "none";
            xattr = "sa";
          };
          options.ashift = "12";
          datasets = {
            "local" = {
              type = "zfs_fs";
            };
            "local/nix" = {
              type = "zfs_fs";
              mountpoint = "/nix";
            };
            "local/root" = {
              type = "zfs_fs";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
