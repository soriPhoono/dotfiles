{namespace, ...}: {
  imports = [
    ./disko.nix
  ];

  ${namespace} = {
    core = {
      hardware = {
        gpu = {
          integrated.amd.enable = true;
          dedicated.nvidia.enable = true;
        };

        hid.xbox_controllers.enable = true;

        bluetooth.enable = true;
      };

      boot.enable = true;

      secrets = {
        enable = true;
        defaultSopsFile = ./secrets.yaml;
      };
    };

    themes.catppuccin.enable = true;
  };
}
