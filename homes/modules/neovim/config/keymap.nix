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
  ];
}
