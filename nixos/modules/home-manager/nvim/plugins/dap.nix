{ ... }: {
  programs.nixvim.plugins = {
    dap = {
      enable = true;

      extensions = {
        dap-ui.enable = true;
      };

      adapters.servers = {

      };
    };
  };
}
