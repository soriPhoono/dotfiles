{
  programs.nixvim.plugins = {
    dap = {
      enable = true;

      extensions = {
        dap-ui = {
          enable = true;

          floating.mappings = { close = [ "<ESC>" "q" ]; };
        };
      };

      configurations = { };
    };
  };
}
