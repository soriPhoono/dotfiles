{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.streaming;
in {
  options = {
    desktop.programs.streaming.enable = lib.mkEnableOption "Enable streaming programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gimp
      audacity
      blender
      davinci-resolve
    ];

    programs.obs-studio.enable = true;
  };
}
