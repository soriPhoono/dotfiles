{ lib, config, ... }:
let cfg = config.terminal.programs.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      colorschemes.catppuccin = {
        enable = true;

        settings = {
          flavour = "mocha";

          transparent_background = true;
        };
      };

      editorconfig.enable = true;

      plugins = {
        airline.enable = true;
      };
    };
  };
}
