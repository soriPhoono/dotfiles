{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.office.obsidian;
in
  with lib; {
    options.userapps.office.obsidian = {
      enable = mkEnableOption "Enable Obsidian";
    };

    config = mkIf cfg.enable {
      programs.obsidian = {
        enable = true;
      };
    };
  }
