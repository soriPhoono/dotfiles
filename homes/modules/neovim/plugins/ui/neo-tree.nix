{
  programs.nixvim = {
    keymaps = [{
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
      mode = [ "n" ];
      options = {
        desc = "Open/Close the file browser";
        silent = true;
      };
    }];

    plugins = {
      neo-tree = {
        enable = true;

        autoCleanAfterSessionRestore = true;
        closeIfLastWindow = true;
      };
    };
  };
}
