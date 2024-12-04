{ ... }: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>Neotree toggle<CR>";
        key = "<leader>e";
        options = {
          silent = true;
          desc = "Open file explorer";
        };
      }
    ];

    plugins = {
      web-devicons.enable = true;
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;

        window.position = "float";
      };
    };
  };
}
