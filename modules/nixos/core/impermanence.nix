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
    enable = lib.mkEnableOption "Enable system level impermanence";

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

  config = lib.mkIf cfg.enable {
    programs.fuse.userAllowOther = true;

    fileSystems."/nix".neededForBoot = true;

    environment.persistence."/nix/system" = {
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
