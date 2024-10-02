{ inputs, ... }: {
  imports = with inputs; [
    ./hardware-configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  core = {
    hardware = {
      bluetooth.enable = true;
      logitech.enable = true;
      graphics.enable = true;
      qmk_keyboard.enable = true;
      xbox_controller.enable = true;
    };

    openssh.enable = true;
  };

  desktop = {
    boot.systemd-boot.enable = true;
    laptop.enable = true;
    hyprland.enable = true;
  };

  programs.droidcam.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';
}
