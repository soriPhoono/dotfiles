# https://github.com/LongerHV/nixos-configuration/blob/master/modules/nixos/homelab/backups.nix
{
  lib,
  config,
  ...
}: let
  cfg = config.server.backup;
in {
  options.server.backup = with lib; {
    enable = mkEnableOption "Enable backup provision service for offsite s3 bucket";
    bucket = mkOption {
      type = types.str;
      description = "Offsite backup uri";
    };
    pruneOpts = mkOption {
      type = with types; listOf str;
      default = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 3"
      ];
      description = "Parameters to pruning options";
      example = [
        "--keep-daily 1"
      ];
    };
    passwordFile = mkOption {
      type = types.str;
      description = "Path to file for repo encryption onsite";
    };
    environmentFile = mkOption {
      type = types.str;
      description = "Path to file with environment variables for backup service";
    };
    services = mkOption {
      type = types.attrs;
      description = "Various services to provision backups for";
    };
  };

  config = lib.mkIf cfg.enable {
    users.groups.restic = {};
    services.restic.backups = builtins.mapAttrs (name: settings:
      {
        initialize = true;
        repository = "${cfg.bucket}/${name}";
        timerConfig = {
          OnCalendar = "00:00";
          RandomizedDelaySec = "4h";
        };
        inherit (cfg) pruneOpts passwordFile environmentFile;
      }
      // settings)
    cfg.services;
  };
}
