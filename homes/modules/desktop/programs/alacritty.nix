{ lib, config, ... }:
let cfg = config.desktop.programs.alacritty;
in {
  options = {
    desktop.programs.alacritty.enable =
      lib.mkEnableOption "Enable alacritty terminal";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings.cursor.style = "Beam";
    };
  };
}
