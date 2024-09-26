{
  programs.nixvim = {
    keymaps = [{
      action = "<cmd>ToggleTerm<CR>";
      key = "<leader>tt";
      mode = [ "n" ];
      options = { silent = true; };
    }];

    plugins = {
      toggleterm = {
        enable = true;

        settings = {
          direction = "float";

          float_opts.border = "curved";
        };
      };
    };
  };
}
