{
  imports = [
    ./disk-config.nix
  ];

  facter.reportPath = ./facter.json;

  core.hostname = "workstation";

  system = {
    enable = true;

    hardware = {
      intel.integrated = {
        enable = true;

        device_id = "";
      };
      amdgpu.dedicated.enable = true;
    };

    boot = {
      plymouth.enable = true;
    };

    networking.enable = true;
    bluetooth.enable = true;

    pipewire.enable = true;

    location.enable = true;
  };

  desktop.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
