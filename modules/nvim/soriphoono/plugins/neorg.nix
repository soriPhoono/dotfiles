{
  autoCmd = [
    {
      command =
        # Lua
        ''
          vim.keymap.set("n", "nc", "<Plug>(neorg.core.looking-glass.magnify-code-block)", { buffer = true })
        '';
      event = [
        "BufEnter"
        "BufWinEnter"
      ];
      pattern = [
        "*.norg"
      ];
    }
  ];

  plugins.neorg = {
    enable = true;

    telescopeIntegration.enable = true;

    settings = {
      load = {
        "core.defaults" = {
          __empty = null;
        };
        "core.keybinds" = {
        };
        "core.dirman" = {
          config = {
            workspaces = {
              notes = "~/Documents/Notes/";
            };
          };
        };
        "core.completion" = {
          config = {
            engine = "nvim-cmp";
          };
        };
      };
    };
  };
}
