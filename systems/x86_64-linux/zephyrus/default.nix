{config, ...}: {
  facter.reportPath = ../../../facter/zephyrus.json;

  sops.secrets."wireless_secrets" = {
    format = "dotenv";
    sopsFile = ../../../secrets/wireless.env;
  };

  core = {
    boot = {
      plymouth.enable = true;
    };

    hardware = {
      enable = true;
      ssd.enable = true;
      android.enable = true;
      gpu = {
        enable = true;
        integrated.amd.enable = true;
        dedicated.nvidia.enable = true;
      };
    };

    networking.wireless = {
      enable = true;

      secretsFile = config.sops.secrets."wireless_secrets".path;

      networks = {
        eaglenet = {};
      };
    };

    services = {
      asusd.enable = true;
      geoclue2.enable = true;
    };

    power.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
  };

  desktop.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
