{
  lib,
  config,
  ...
}: let
  cfg = config.system.impermanence;
in {
  options.system.impermanence = {
    enable = lib.mkEnableOption "Enable system level impermanence";

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

  config = lib.mkIf cfg.enable {
    disko.devices.zpool.zroot = lib.mkForce {
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
        "local/home" = {
          type = "zfs_fs";
          mountpoint = "/home";
        };
        "local/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
        };
        "local/root" = {
          type = "zfs_fs";
          mountpoint = "/";
          postCreateHook = "zfs list -t snapshot -H -o name | grep \"^zroot/local/root@blank$\" || zfs snapshot zroot/local/root@blank";
        };
        "local/persist" = {
          type = "zfs_fs";
          mountpoint = "/persist";
        };
      };
    };

    boot.initrd.postDeviceCommands = ''
      zfs rollback -r zroot/local/root@blank
    '';

    fileSystems."/persist".neededForBoot = true;

    environment.persistence."/persist" = {
      inherit (cfg) files;

      enable = true;

      hideMounts = true;

      directories =
        [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
        ]
        ++ cfg.directories;
    };

    programs.fuse.userAllowOther = true;
  };
}
