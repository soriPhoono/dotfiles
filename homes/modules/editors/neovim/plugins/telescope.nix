{
  programs = {
    nixvim = {
      keymaps = [
        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<C-p>";
          mode = [ "n" ];
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>fg";
          mode = [ "n" ];
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>Telescope buffers<CR>";
          key = "<leader>fb";
          mode = [ "n" ];
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>Telescope help_tags<CR>";
          key = "<leader>fh";
          mode = [ "n" ];
          options = {
            silent = true;
          };
        }
      ];

      plugins = {
        web-devicons.enable = true;
        telescope.enable = true;
      };
    };

    ripgrep.enable = true;
  };
}
