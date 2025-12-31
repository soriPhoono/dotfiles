{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.managers.hyprland;
in with lib; {
  imports = [
    ./saphire.nix
  ];

  options.desktop.environments.managers.hyprland = {
    enable = mkEnableOption "Enable hyprland desktop environment.";

    configurationName = mkOption {
      type = types.str;
      default = "default";
      description = "The name of the hyprland configuration to use.";
    };
  };

  config = mkIf cfg.enable {
    desktop.environments = {
      uwsm.enable = true;
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}
