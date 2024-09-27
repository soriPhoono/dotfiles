{
  programs.nixvim.keymaps = builtins.map (v: v // { options.silent = true; }) [
    {
      key = "<leader>va";
      action = "gg<S-v>G";
      mode = [ "n" ];
      options.desc = "Select all";
    }

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
      action = "<cmd>quitall<CR>";
      mode = [ "n" ];
      options.desc = "Quit all";
    }

    {
      key = "<leader>te";
      action = "<cmd>tabedit<CR>";
      mode = [ "n" ];
      options.desc = "Open new tab";
    }
    {
      key = "<Tab>";
      action = "<cmd>tabnext<CR>";
      mode = [ "n" ];
      options.desc = "Go to next tab";
    }
    {
      key = "<S-Tab>";
      action = "<cmd>tabprev<CR>";
      mode = [ "n" ];
      options.desc = "Go to previous tab";
    }
    {
      key = "<leader>tc";
      action = "<cmd>tabclose<CR>";
      mode = [ "n" ];
      options.desc = "Close current tab";
    }

    {
      key = "<leader>wsh";
      action = "<cmd>split<CR>";
      mode = [ "n" ];
      options.desc = "Split current window horizontally";
    }
    {
      key = "<leader>wsv";
      action = "<cmd>vsplit<CR>";
      mode = [ "n" ];
      options.desc = "Split current window vertically";
    }

    {
      key = "<leader>wmh";
      action = "<C-w>h";
      mode = [ "n" ];
      options.desc = "Move current window focus left";
    }
    {
      key = "<leader>wmk";
      action = "<C-w>k";
      mode = [ "n" ];
      options.desc = "Move current window focus up";
    }
    {
      key = "<leader>wmj";
      action = "<C-w>j";
      mode = [ "n" ];
      options.desc = "Move current window focus down";
    }
    {
      key = "<leader>wml";
      action = "<C-w>l";
      mode = [ "n" ];
      options.desc = "Move current window focus right";
    }

    {
      key = "<leader>wrh";
      action = "<C-w><";
      mode = [ "n" ];
      options.desc = "Expand current window left";
    }
    {
      key = "<leader>wrl";
      action = "<C-w>>";
      mode = [ "n" ];
      options.desc = "Expand current window up";
    }
    {
      key = "<leader>wrk";
      action = "<C-w>+";
      mode = [ "n" ];
      options.desc = "Expand current window down";
    }
    {
      key = "<leader>wrj";
      action = "<C-w>-";
      mode = [ "n" ];
      options.desc = "Expand current window right";
    }

    {
      key = "<leader>dp";
      action =
        # lua
        ''
          function()
            vim.diagnostic.goto_next()
          end
        '';
      mode = [ "n" ];
      options.desc = "Go to next problem in the current file";
    }
  ];
}
