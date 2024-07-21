{ lib, config, ...}:
let cfg = config.terminal.emulators.alacritty;
in {
  options = {
    terminal.emulators.alacritty.enable = lib.mkEnableOption "Enable alacritty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          blur = true;

          decorations = "None";
          startup_mode = "Maximized";
        };

        cursor.style = "Beam";
      };
    };
  };
}
