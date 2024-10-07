{
  imports = [
    ./hardware-configuration.nix
  ];

  virtualization.virtualbox.guest.enable = true;

  core = {
    hardware = {
      bluetooth.enable = true;
      logitech.enable = true;
      xbox_controller.enable = true;
    };

    openssh.enable = true;
  };

  desktop = {
    boot.enable = true;
    regreet.enable = true;
    hyprland.enable = true;

    programs.libvirtd.enable = true;
  };

  laptop.enable = true;
}
