{
  facter.reportPath = ../../../facter/testbench.json;

  services.greetd.settings.initial_session.user = "soriphoono";

  core = {
    boot.secrets.defaultSopsFile = ./vault.yaml;

    hardware = {
      enable = true;

      android.enable = true;
      bluetooth.enable = true;
      monitors.enable = true;

      gpu = {
        enable = true;
        integrated.amd.enable = true;
      };
    };

    networking = {
      enable = true;
      wireless.enable = true;
      tailscale.enable = true;
    };

    services = {
      geoclue2.enable = true;
      pipewire.enable = true;
      tlp.enable = true;
    };
  };

  desktop.environments.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
