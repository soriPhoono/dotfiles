{
  core = {
    hardware = {
      enable = true;

      defaultReportPath = ./facter.json;
    };

    boot = {
      secrets.defaultSopsFile = ./secrets.yaml;

      plymouth.enable = true;
    };
  };

  themes.catppuccin.enable = true;
}
