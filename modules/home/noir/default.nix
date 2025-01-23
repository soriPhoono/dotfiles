{
  lib,
  config,
  ...
}: let
  cfg = config.noir;
in {
  imports = [
    ./hyprland
  ];

  options.noir = {
    enable = lib.mkEnableOption "Enable hyprland desktop configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty.enable = true;
  };
}
