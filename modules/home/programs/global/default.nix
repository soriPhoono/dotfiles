{ lib, pkgs, config, ... }:
let cfg = config.programs;
in {
  options = {
    programs = {
      enable = lib.mkEnableOption "Enable userspace default programs";
      desktop.enable = lib.mkEnableOption "Enable desktop programs";
      development.enable = lib.mkEnableOption "Enable development programs";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      imagemagick

      unrar

      yt-dlp
      spotdl
      ytmdl
    ];
  };
}
