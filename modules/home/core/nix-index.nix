{ lib, config, ... }:
let
  cfg = config.core.nix-index;
in
{
  options.core.nix-index = {
    enable = lib.mkEnableOption "Enable nix-index";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-index = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = config.core.fish.enable;
    };
  };
}
