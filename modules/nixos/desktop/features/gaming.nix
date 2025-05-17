{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.features.gaming;
in {
  options.desktop.features.gaming = {
    enable = lib.mkEnableOption "Enable steam integration";

    featureType = lib.mkOption {
      type = with lib.types; listOf (enum ["desktop" "console" "streaming_server"]);
      default = ["desktop"];
      description = "Feature variant for final resulting package set";
      example = ["desktop" "console"];
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;
      };

      steam = {
        enable = true;

        extest.enable = true;

        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;

        protontricks.enable = true;
      };
    };

    jovian.steam = {
      enable = lib.any (feature: feature == "console") cfg.featureType;
      autoStart = cfg.featureType == ["console"];
    };
  };
}
