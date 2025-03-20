{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.ags;
in {
  options.desktop.programs.ags = {
    enable = lib.mkEnableOption "Enable ags shell based environment";

    config = {
      configDir = lib.mkOption {
        type = lib.types.path;

        description = "The path to typescript configuration files";
      };

      extraPackages = lib.mkOption {
        type = with lib.types; listOf package;

        default = [];

        description = "The extra packages to add to the ags runtime";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ags = {
      # inherit (cfg.config) configDir;

      enable = true;

      /*
      extraPackages = with pkgs;
        [
        ]
        ++ cfg.config.extraPackages;
      */
    };
  };
}
