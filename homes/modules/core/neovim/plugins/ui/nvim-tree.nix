{
  programs.nixvim = {
    keymaps = [{
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<CR>";
      mode = [ "n" ];
      options = {
        desc = "Open/Close the file browser";
        silent = true;
      };
    }];

    plugins = {
      nvim-tree = {
        enable = true;

        autoClose = true;
        disableNetrw = true;
        hijackCursor = true;
      };
    };
  };
}
