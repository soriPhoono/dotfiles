{
  core = {
    hostname = "testing";
  };

  system = {
    boot = {
      enable = true;
      plymouth.enable = true;
    };

    themes = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
