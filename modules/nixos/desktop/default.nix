{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop;
in {
  options.desktop = {
    enable = lib.mkEnableOption "Enable core desktop configurations";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      carlito
    ];
  };
}
