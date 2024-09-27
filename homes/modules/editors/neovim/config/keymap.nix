{
  programs.nixvim.keymaps = builtins.map (v: v // { options.silent = true; }) [
    {
      key = "<leader>w";
      action = "<cmd>write<CR>";
      mode = [ "n" ];
      options.desc = "Save to disk";
    }
    {
      key = "<leader>q";
      action = "<cmd>quit<CR>";
      mode = [ "n" ];
      options.desc = "Save and quit";
    }
  ];
}
