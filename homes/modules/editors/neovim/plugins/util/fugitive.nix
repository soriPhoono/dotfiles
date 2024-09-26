{
  programs.nixvim = {
    keymaps = builtins.map (v: v // { options.silent = true; }) [{
      key = "<leader>ga";
      action = "<cmd>G add %<CR>";
      mode = [ "n" ];
      options.desc = "Add the current file to the index";
    }];

    plugins.fugitive = { enable = true; };
  };
}
