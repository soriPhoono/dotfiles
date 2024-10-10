{
  imports = [
    ./hardware-configuration.nix
  ];

  core = {
    hardware.enable = true;
    openssh.enable = true;
  };

  desktop = {
    boot.enable = true;
    regreet.enable = true;
    hyprland.enable = true;
  };
}
