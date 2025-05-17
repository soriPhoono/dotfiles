{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.zellij;
in {
  options.core.programs.zellij = {
    enable = lib.mkEnableOption "Enable zellij terminal multiplexer workspace";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
    };
  };
}
