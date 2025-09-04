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

    services.wivrn = {
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

    # home-manager.users = 
    #   builtins.mapAttrs (user: _: {
    #     xdg.configFile = {
    #       "openvr/openvrpaths.vrpath".text = ''
    #         {
    #           "config": [
    #             "${config.home-manager.users.${user}.xdg.dataHome}/Steam/config"
    #           ],
    #           "external_drivers": null,
    #           "jsonid": "vrpathreg",
    #           "log": [
    #             "${config.home-manager.users.${user}.xdg.dataHome}/Steam/logs"
    #           ],
    #           "runtime": [
    #             "${pkgs.opencomposite}/lib/opencomposite",
    #           ],
    #           "version": 1
    #         }
    #       '';
    #     };
    #   })
    #   config.core.users;
  };
}
