{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.gaming;
in {
  options.desktop.features.gaming = {
    enable = lib.mkEnableOption "Enable steam integration";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris
      bottles

      protonplus

      mangohud

      prismlauncher
      gzdoom
    ];

    programs = {
      # Gamemode for advanced performance tuning
      gamemode = {
        enable = true;
        enableRenice = true;
      };

      # Desktop steam on desktop mode compliant systems
      steam = {
        enable = true;

        extest.enable = true;

        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;

        protontricks.enable = true;
      };
    };
  };
}
