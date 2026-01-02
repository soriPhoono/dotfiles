{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.managers.hyprland;
in
  with lib; {
    imports = [
      ./saphire.nix
    ];

    options.desktop.environments.managers.hyprland = {
      enable = mkEnableOption "Enable hyprland desktop environment.";

      configurationName = mkOption {
        type = with types; nullOr (enum ["saphire"]);
        default = null;
        description = "The full configuration name to use for hyprland.";
        example = "saphire";
      };
    };

    config = mkIf cfg.enable {
      desktop.environments = {
        managers.enable = true;
        display_managers.greetd.enable = (config.desktop.environment == null);
      };

      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };

      home-manager.users =
        builtins.mapAttrs (name: _: {
          desktop.environments.hyprland.enable = true;
        })
        config.core.users;
    };
  }
