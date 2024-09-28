{
  programs.nixvim = {
    keymaps = [{
      action = "<cmd>Commentary<CR>";
      key = "<leader>c";
      mode = [ "n" ];
      options.silent = true;
    }];

    plugins.commentary.enable = true;
  };
}
