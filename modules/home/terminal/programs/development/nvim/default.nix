{ lib, config, ... }:
let cfg = config.terminal.programs.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin = {
        enable = true;

        settings = {
          flavour = "mocha";

          transparent_background = true;
        };
      };

      editorconfig.enable = true;

      plugins = {
        lualine.enable = true;
        neo-tree = {
          enable = true;

          autoCleanAfterSessionRestore = true;
          closeIfLastWindow = true;
        };
      };
    };
  };
}
