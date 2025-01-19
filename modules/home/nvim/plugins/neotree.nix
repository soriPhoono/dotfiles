{
  lib,
  config,
  ...
}: let
  cfg = config.nvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.neo-tree = {
        enable = true;

        filesystem = {
          window = {
            mappings = {
              "\\" = "close_window";
            };
          };
        };
      };

      keymaps = [
        {
          key = "\\";
          action = "<cmd>Neotree reveal<cr>";
          options = {
            desc = "Open file browser";
          };
        }
      ];
    };
  };
}
