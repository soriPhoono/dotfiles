{ inputs
, ...
}: {
  imports = with inputs; [
    ./hardware-configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  core = {
    boot.systemd-boot.enable = true;
    hardware = {
      bluetooth.enable = true;
      logitech.enable = true;
      qmk_keyboard.enable = true;
      xbox_controller.enable = true;
    };
  };

  desktop.hyprland.enable = true;
}
