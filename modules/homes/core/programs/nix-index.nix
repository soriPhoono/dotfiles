{ lib, config, ... }:
let
  cfg = config.core.programs.nix-index;
in
{
  options = {
    core.programs.nix-index = {
      enable = lib.mkEnableOption "Enable nix-index";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nix-index = {
      enable = true;

      enableBashIntegration = config.core.shells.bash.enable;
      enableFishIntegration = config.core.shells.fish.enable;
    };
  };
}
