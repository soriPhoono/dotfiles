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

    featureType = lib.mkOption {
      type = with lib.types; listOf (enum ["desktop" "vr" "console" "streaming_server"]);
      default = ["desktop"];
      description = "Feature variant for final resulting package set";
      example = ["desktop" "console"];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      (
        if (lib.any (feature: feature == "desktop") cfg.featureType)
        then [
          prismlauncher
          gzdoom
        ]
        else []
      )
      ++ (
        if (lib.any (feature: feature == "vr") cfg.featureType)
        then [
          opencomposite
          wlx-overlay-s
        ]
        else []
      );

    programs = {
      # Gamemode for advanced performance tuning
      gamemode = {
        enable = true;
        enableRenice = true;
      };

      # Desktop steam on desktop mode compliant systems
      steam = {
        enable = lib.any (feature: feature == "desktop") cfg.featureType;

        extest.enable = true;

        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;

        protontricks.enable = true;
      };
    };

    services.wivrn = lib.mkIf (lib.any (feature: feature == "vr") cfg.featureType) {
      enable = true;
      openFirewall = true;
      defaultRuntime = true;
      autoStart = true;
    };

    home-manager.users =
      lib.mkIf (lib.any (feature: feature == "vr") cfg.featureType)
      (lib.listToAttrs (map (user: {
          inherit (user) name;

          value = {
            xdg.configFile = {
              "openxr/1/active_runtime.json".source = "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";

              "openvr/openvrpaths.vrpath".text = ''
                {
                  "config" :
                  [
                    "~/.local/share/Steam/config"
                  ],
                  "external_drivers" : null,
                  "jsonid" : "vrpathreg",
                  "log" :
                  [
                    "~/.local/share/Steam/logs"
                  ],
                  "runtime" :
                  [
                    "${pkgs.opencomposite}/lib/opencomposite"
                  ],
                  "version" : 1
                }
              '';
            };
          };
        })
        config.core.users));

    # SteamOS steam on console mode compliant systems
    jovian.steam = {
      enable = lib.any (feature: feature == "console") cfg.featureType;
      autoStart = cfg.featureType == ["console"];
    };
  };
}
