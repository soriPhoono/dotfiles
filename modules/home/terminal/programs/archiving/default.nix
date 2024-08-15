{ lib, pkgs, config, ... }:
let cfg = config.terminal.programs.archiving;
in {
  options = {
    terminal.programs.archiving.enable = lib.mkEnableOption "Enable archiving programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      imagemagick

      zip
      unzip
      p7zip
      unrar

      yt-dlp
      spotdl
      ytmdl
    ];
  };
}
