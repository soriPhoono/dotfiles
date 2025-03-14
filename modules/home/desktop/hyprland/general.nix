{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland;
in {
  imports = [
    ./autostart.nix
    ./binds.nix
    ./rules.nix
  ];

  options.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland wayland compositor";

    environmentVariables = lib.mkOption {
      type = with lib.types; attrsOf str;

      default = {};

      description = "Environment variables for the session compositor";
    };

    extraSettings = lib.mkOption {
      type = with lib.types; attrs;

      default = {};

      description = "Extra hyprland settings";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];

      settings =
        {
          env =
            lib.mapAttrsToList
            (name: value: "${name},${value}")
            cfg.environmentVariables;
        }
        // cfg.extraSettings;
    };
  };
}
