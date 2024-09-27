{
  programs.nixvim.keymaps = builtins.map (v: v // { options.silent = true; }) [
    {
      key = "<leader>ww";
      action = "<cmd>write<CR>";
      mode = [ "n" ];
      options.desc = "Save to disk";
    }
    {
      key = "<leader>wq";
      action = "<cmd>write<CR><cmd>quit<CR>";
      mode = [ "n" ];
      options.desc = "Save and quit";
    }

    {
      key = "<leader>wc";
      action = "<cmd>close<CR>";
      mode = [ "n" ];
      options.desc = "Close the current window";
    }
    {
      key = "<leader>wsh";
      action = "<cmd>hsplit<CR>";
      mode = [ "n" ];
      options.desc = "Split the window pane horizontally";
    }
    {
      key = "<leader>wsv";
      action = "<cmd>vsplit<CR>";
      mode = [ "n" ];
      options.desc = "Split the window pane vertically";
    }
  ];
}
