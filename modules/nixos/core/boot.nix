{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.boot;
in {
  options.${namespace}.core.boot = {
    enable = lib.mkEnableOption "Enable bootloader";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "quiet"
        "systemd.show_status=false"
        "udev.log_level=3"
      ];

      initrd.verbose = false;

      consoleLogLevel = 0;

      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };

      plymouth.enable = true;
    };

    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = "/dev/vdb";
          content = {
            type = "gpt";
            partitions = let
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
                };
              };
            in {
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
              luks = lib.mkIf config.${namespace}.core.secrets.enable {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  passwordFile = config.sops.secrets.disk_password.path; # Interactive
                  settings.allowDiscards = true;
                  content = basePartition;
                };
              };
              root = lib.mkIf (!config.${namespace}.core.secrets.enable) {
                size = "100%";
                content = basePartition;
              };
            };
          };
        };
      };
    };

    zramSwap.enable = true;

    security.sudo.wheelNeedsPassword = false;
  };
}
