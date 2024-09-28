{
  programs = {
    nixvim = {
      plugins = {
        web-devicons.enable = true;
        telescope = {
          enable = true;

          keymaps = builtins.mapAttrs (n: v: v // { options.silent = true; }) {
            "<leader>fh" = {
              action = "help_tags";
              options = { desc = "Telescope find help tags"; };
            };
            "<leader>fb" = {
              action = "buffers";
              options = { desc = "Telescope find buffer"; };
            };
            "<leader>ff" = {
              action = "find_files";
              options = { desc = "Telescope find_files"; };
            };
            "<leader>fg" = {
              action = "live_grep";
              options = { desc = "Telescope live_grep"; };
            };
          };
        };
      };
    };

    ripgrep.enable = true;
  };
}
