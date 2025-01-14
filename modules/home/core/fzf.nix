{
  lib,
  config,
  ...
}: let
  cfg = config.core.fzf;
in {
  options.core.fzf = {
    enable = lib.mkEnableOption "Enable fzf";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = config.core.fish.enable;

      defaultCommand = "fd --type file";
      defaultOptions = [
        "--ansi"
      ];
    };
  };
}
