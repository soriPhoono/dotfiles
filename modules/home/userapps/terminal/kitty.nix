{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.terminal.kitty;
in
  with lib; {
    options.userapps.terminal.kitty = {
      enable = mkEnableOption "Enable kitty terminal emulator application customisation";
    };

    config = mkIf cfg.enable {
      programs.kitty = {
        enable = true;
      };
    };
  }
