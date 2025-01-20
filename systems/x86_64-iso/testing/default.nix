{
  core = {
    hostname = "testing";
    secrets.defaultSopsFile = ../../../secrets/system.yaml;
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
