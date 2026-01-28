{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.development.terminal.kitty;
in
  with lib; {
    options.userapps.development.terminal.kitty = {
      enable = mkEnableOption "Enable kitty terminal emulator application customisation";
    };

    config = mkIf cfg.enable {
      programs.kitty = {
        enable = true;
      };
    };
  }
