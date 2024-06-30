{ pkgs, vars, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/core
    ../../modules/nixos/hardware

    ../../modules/nixos/programs/gnupg.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/programs/virtualisation.nix

    ../../modules/nixos/services/fprintd.nix
    ../../modules/nixos/services/openrgb.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/printing.nix
    ../../modules/nixos/services/zram-generator.nix

    ../../modules/nixos/desktops/kde.nix
  ];

  hardware = {
    nvidia.open = true;

    graphics = {
      enable = true;
      enable32Bit = true;

      # TODO: setup vaapi/vdpau/cuda/nvdec/nvenc
    };
  };

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';

  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  system.stateVersion = "${vars.stateVersion}";
}
