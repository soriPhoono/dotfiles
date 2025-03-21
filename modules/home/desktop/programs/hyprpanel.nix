{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.hyprpanel;
in {
  options.desktop.programs.hyprpanel = {
    enable = lib.mkEnableOption "Enable Hyprpanel";

    layout = lib.mkOption {
      type = with lib.types; attrs;
      description = "The settings for hyprpanel";

      default = {};
    };

    settings = lib.mkOption {
      type = with lib.types; attrs;
      description = "The settings for hyprpanel";

      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprpanel = {
      inherit (cfg) layout settings;

      enable = true;
      systemd.enable = true;
      hyprland.enable = true;
      overwrite.enable = true;
    };
  };
}
