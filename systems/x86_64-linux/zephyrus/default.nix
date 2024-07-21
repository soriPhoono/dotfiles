{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.nvidia.open = true;

  core = {
    boot.enable = true;

    hardware = {
      bluetooth.enable = true;
      opengl.enable = true;
      xbox.enable = true;
    };

    networking.networkManager.enable = true;
  };

  hyprland.enable = true;

  programs.desktop.steam.enable = true;
  services.openrgb.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=poweroff
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';
}
