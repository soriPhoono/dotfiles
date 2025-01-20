{
  core = {
    hostname = "testing";
    secrets.defaultSopsFile = ../../../secrets/system.yaml;
  };

  system.themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
