{ lib, config, ... }:
let cfg = config.core.programs.eza;
in {
  options = {
    core.programs.eza = {
      enable = lib.mkEnableOption "Enable eza ls replacement";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableFishIntegration = config.core.shells.fish.enable;

      extraOptions = [ "--group-directories-first" ];

      git = true;
      icons = "auto";
    };
  };
}
