{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.fzf;
in {
  options.core.programs.fzf = {
    enable = lib.mkEnableOption "Enable fzf";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = config.core.shells.fish.enable;

      defaultCommand = "fd --type file";
      defaultOptions = [
        "--ansi"
      ];
    };
  };
}
