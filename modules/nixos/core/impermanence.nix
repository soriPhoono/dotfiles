{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.core.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.core.impermanence = {
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Extra directories to back up and persist between sessions";
      default = [];
    };

    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Extra directories to back up and persist between sessions";
      default = [];
    };
  };

  config = {
    programs.fuse.userAllowOther = true;

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
  };
}
