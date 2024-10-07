{ lib, config, nixosConfig, ... }:
let cfg = config.core.shells.fish;
in {
  options = {
    core.shells.fish = {
      enable = lib.mkEnableOption "Enable fish shell";

      extraShellInit = lib.mkOption {
        type = with lib.types; lines;
        description = "Extra arguments to add to shellInit script";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    core.shells.enable = lib.mkDefault true;

    programs.fish = {
      enable = nixosConfig.programs.fish.enable;

      shellInitLast = ''
        set fish_greeting
      '' + cfg.extraShellInit;
    };
  };
}
