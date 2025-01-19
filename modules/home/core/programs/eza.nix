{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.programs.eza;
in {
  options.core.programs.eza = {
    enable = lib.mkEnableOption "Enable eza config";
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;

      enableFishIntegration = config.core.shells.fish.enable;

      git = true;
      icons = "auto";

      extraOptions = [
        "--group-directories-first"
      ];
    };
  };
}
