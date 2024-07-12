{ pkgs, vars, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/core
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/graphics.nix

    ../../modules/services/pipewire.nix
  ];

  hardware.nvidia.open = true;

  services = {
    logind.extraConfig = ''
      HandlePowerKey=ignore
      HandleLidSwitch=suspend
      HandleLidSwitchExternalPower=suspend
    '';

    fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  };
}
