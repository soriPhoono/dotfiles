{ lib, config, ... }:
let cfg = config.core.programs.nix-index;
in {
  options = {
    core.programs.nix-index = {
      enable = lib.mkEnableOption "Enable nix-index";
    };
  };

  config = lib.mkIf cfg.enable {
    nix-index = {
      enable = true;

      enableFishIntegration = config.core.shells.fish.enable;
    };
  };
}
