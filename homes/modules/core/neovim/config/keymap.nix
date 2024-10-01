builtins.map (v: v // { options.silent = true; }) [
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
    key = "<leader>te";
    action = "<cmd>tabedit<CR>";
    mode = [ "n" ];
    options.desc = "Open new tab";
  }
  {
    key = "<leader>tn";
    action = "<cmd>tabnext<CR>";
    mode = [ "n" ];
    options.desc = "Go to next tab";
  }
  {
    key = "<leader>tp";
    action = "<cmd>tabprev<CR>";
    mode = [ "n" ];
    options.desc = "Go to previous tab";
  }
  {
    key = "<leader>tq";
    action = "<cmd>tabclose<CR>";
    mode = [ "n" ];
    options.desc = "Close current tab";
  }

  {
    key = "<leader>wh";
    action = "<cmd>split<CR>";
    mode = [ "n" ];
    options.desc = "Split current window horizontally";
  }
  {
    key = "<leader>wv";
    action = "<cmd>vsplit<CR>";
    mode = [ "n" ];
    options.desc = "Split current window vertically";
  }
  {
    key = "<leader>wq";
    action = "<cmd>close<CR>";
    mode = [ "n" ];
    options.desc = "Close current window";
  }
]
