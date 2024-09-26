{
  programs = {
    nixvim = {
      plugins = {
        web-devicons.enable = true;
        telescope = {
          enable = true;

          keymaps = builtins.mapAttrs (n: v: v // { options.silent = true; }) {
            "<leader>fh" = {
              action = "<cmd>Telescope help_tags<CR>";
              options = { desc = "Telescope find help tags"; };
            };
            "<leader>fb" = {
              action = "<cmd>Telescope buffers<CR>";
              options = { desc = "Telescope find buffer"; };
            };
            "<leader>ff" = {
              action = "<cmd>Telescope find_files<CR>";
              options = { desc = "Telescope find_files"; };
            };
            "<leader>fg" = {
              action = "<cmd>Telescope live_grep<CR>";
              options = { desc = "Telescope live_grep"; };
            };
          };
        };
      };
    };

    ripgrep.enable = true;
  };
}
