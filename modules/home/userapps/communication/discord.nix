{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.communication.discord;
in
  with lib; {
    options.userapps.communication.discord = {
      enable = mkEnableOption "Enable Discord";
    };

    config = mkIf cfg.enable {
      programs.discord = {
        enable = true;
      };
    };
  }
