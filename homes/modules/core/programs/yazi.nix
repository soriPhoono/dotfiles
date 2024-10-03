{ lib, config, ... }:
let cfg = config.core.programs.yazi;
in {
  options = {
    core.programs.yazi = {
      enable = lib.mkEnableOption "Enable yazi file browser";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = config.core.shells.fish.enable;
    };
  };
}
