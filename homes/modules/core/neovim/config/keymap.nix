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
      action = "<cmd>quit<CR>";
      mode = [ "n" ];
      options.desc = "Quit";
    }
    {
      key = "<leader>Q";
      action = "<cmd>quit!<CR>";
      mode = [ "n" ];
      options.desc = "Quit all";
    }

    {
      key = "<leader>va";
      action = "gg<S-v>G";
      mode = [ "n" ];
      options.desc = "Select all";
    }

    {
      key = "<C-w>q";
      action = "<cmd>close<CR>";
      mode = [ "n" ];
      options.desc = "Close current window";
    }

    {
      key = "<leader>dn";
      action =
        # lua
        "function() vim.diagnostic.goto_next() end";
      mode = [ "n" ];
      options.desc = "Goto next diagnostic entry";
    }
    {
      key = "<leader>dp";
      action =
        # lua
        "function() vim.diagnostic.goto_prev() end";
      mode = [ "n" ];
      options.desc = "Goto previous diagnostic entry";
    }
    {
      key = "<leader>de";
      action =
        # lua
        "function() vim.diagnostic.open_float() end";
      mode = [ "n" ];
      options.desc = "Open current diagnostic message";
    }
  ];
}
