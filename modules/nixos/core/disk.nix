{
  lib,
  config,
  namespace,
  ...
}: let
  basePartition = {
    type = "btrfs";
    extraArgs = ["-f"];
    subvolumes = {
      "/root" = {
        mountpoint = "/";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      "/home" = {
        mountpoint = "/home";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      "/nix" = {
        mountpoint = "/nix";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
      "/swap" = {
        mountpoint = "/.swapvol";
        swap.swapfile.size = "20M";
      };
    };
  };
in {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vdb";
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
            luks = lib.mkIf config.${namespace}.core.secrets.authorized {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = config.sops.secrets.disk_password.path; # Interactive
                settings.allowDiscards = true;
                additionalKeyFiles = ["/tmp/additionalSecret.key"];
                content = basePartition;
              };
            };
            root = lib.mkIf (!config.${namespace}.core.secrets.authorized) {
              size = "100%";
              content = basePartition;
            };
          };
        };
      };
    };
  };
}
