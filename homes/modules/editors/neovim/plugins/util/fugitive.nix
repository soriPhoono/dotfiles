{
  programs.nixvim = {
    keymaps = builtins.map (v: v // { options.silent = true; }) [
      {
        key = "<leader>ga";
        action = "<cmd>G add %<CR>";
        mode = [ "n" ];
        options.desc = "Add the current file to the index";
      }
      {
        key = "<leader>gc";
        action = "<cmd>G commit<CR>";
        mode = [ "n" ];
        options.desc =
          "Commit the current altered working tree to the repository";
      }
    ];

    plugins.fugitive = { enable = true; };
  };
}
