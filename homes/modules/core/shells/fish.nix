{ lib, config, ... }:
let cfg = config.core.shells.fish;
in {
  options = {
    core.shells.fish.enable = lib.mkEnableOption "Enable fish shell";
  };

  config = lib.mkIf cfg.enable {
    core.shells.enable = true;

    programs = {
      fish = {
        enable = true;

        interactiveShellInit = ''
          set fish_greeting
        '';
      };
    };
  };
}
