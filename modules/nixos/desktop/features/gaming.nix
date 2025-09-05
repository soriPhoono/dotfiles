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

    vr.enable = lib.mkEnableOption "Enable VR support with WiVRn";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris

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

    services.wivrn = lib.mkIf cfg.vr.enable {
      enable = true;
      defaultRuntime = true;
      highPriority = true;
      autoStart = true;
      steam.importOXRRuntimes = true;
      # Config for WiVRn (https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md)
      config = {
        enable = true;
        json = {
          # 1.0x foveation scaling
          scale = 1.0;
          # 100 Mb/s
          bitrate = 100000000;
          encoders = [
            {
              encoder = "vaapi";
              codec = "h265";
              # 1.0 x 1.0 scaling
              width = 1.0;
              height = 1.0;
              offset_x = 0.0;
              offset_y = 0.0;
            }
          ];
        };
      };
    };
  };
}
