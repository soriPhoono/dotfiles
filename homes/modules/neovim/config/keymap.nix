{
  programs.nixvim.keymaps = builtins.map (v: v // { options.silent = true; }) [
    {
      key = "<leader>s";
      action = "<cmd>write<CR>";
      mode = [ "n" ];
      options.desc = "Save to disk";
    }
    {
      key = "<leader>q";
      action = "<cmd>write<CR><cmd>quit<CR>";
      mode = [ "n" ];
      options.desc = "Save and quit";
    }

    {
      key = "<leader>wcc";
      action = "<cmd>close<CR>";
      mode = [ "n" ];
      options.desc = "Close the current window";
    }
    {
      key = "<leader>wca";
      action = "<cmd>only<CR>";
      mode = [ "n" ];
      options.desc = "Close all current windows other than the active";
    }
    {
      key = "<leader>wsh";
      action = "<cmd>split<CR>";
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
