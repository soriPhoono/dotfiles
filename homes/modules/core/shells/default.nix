{ lib, config, ... }:
let cfg = config.core.shells;
in {
  imports = [ ./starship.nix ./fish.nix ./fastfetch.nix ];

  options = {
    core.shells.enable = lib.mkEnableOption "Enable core shell environment";
  };

  config = lib.mkIf cfg.enable {
    core.shells.starship.enable = lib.mkDefault true;
    core.shells.fastfetch.enable = lib.mkDefault true;

    programs = {
      nix-index = {
        enable = true;

        enableFishIntegration = config.core.shells.fish.enable;
      };
    };
  };
}
