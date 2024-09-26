{
  programs.nixvim = {
    keymaps = builtins.map (v: v // { options.silent = true; }) [{
      key = "<leader>gt";
      action = "<cmd>Gitsigns toggle_signs<CR>";
      mode = [ "n" ];
      options.desc = "Toggle git gutter signs";
    }];

    plugins.gitsigns = {
      enable = true;

      settings.current_line_blame = true;
    };
  };
}
