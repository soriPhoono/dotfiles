{
  plugins.neorg = {
    enable = true;

    telescopeIntegration.enable = true;

    settings = {
      load = {
        "core.defaults" = {
          __empty = null;
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
