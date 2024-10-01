{ lib, config, ... }:
let cfg = config.core.shells;
in {
  imports = [ ./fastfetch.nix ./fish.nix ];

  options = {
    core.shells.enable = lib.mkEnableOption "Enable core shell environment";
  };

  config = lib.mkIf cfg.enable {
    core.shells.fastfetch.enable = true;

    nix-index = {
      enable = true;

      enableFishIntegration = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = cfg.fish.enable;
      enableTransience = cfg.fish.enable;

      settings = {
        add_newline = true;

        format = "$character";
        right_format = "$all";

        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[➜](bold red) ";
        };
      };
    };
  };
}
