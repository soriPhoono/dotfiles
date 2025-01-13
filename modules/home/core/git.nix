{ lib, config, ... }:
let
  cfg = config.core.git;
in
{
  options.core.git = {
    enable = lib.mkEnableOption "Enable git config";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      aliases = {
        co = "checkout";
      };

      delta = {
        enable = true;

        options = { };
      };
    };
  };
}
