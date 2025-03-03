{
  facter.reportPath = ../../../facter/testbench.json;

  core = {
    boot.secrets.defaultSopsFile = ./vault.yaml;

    hardware = {
      enable = true;
      android.enable = true;
      bluetooth.enable = true;
      monitors.enable = true;
      ssd.enable = true;

      gpu = {
        enable = true;
        integrated.amd.enable = true;
      };
    };

    networking = {
      enable = true;
      wireless.enable = true;
      openssh.enable = true;
    };

    services = {
      geoclue2.enable = true;
      pipewire.enable = true;
    };

    suites = {
      power.enable = true;
    };
  };

  desktop.environments.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
