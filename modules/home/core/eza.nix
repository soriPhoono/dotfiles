{ lib, pkgs, config, ... }:
let
  cfg = config.core.eza;
in
{
  options.core.eza = {
    enable = lib.mkEnableOption "Enable eza config";
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;

      enableFishIntegration = true;

      git = true;
      icons = "auto";

      extraOptions = [
        "--group-directories-first"
      ];
    };
  };
}
