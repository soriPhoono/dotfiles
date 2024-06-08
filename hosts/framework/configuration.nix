{ ... }: {
  imports = [
    ../../modules/nixos/boot
    ../../modules/nixos/core

    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/opengl.nix
    ../../modules/nixos/hardware/xbox.nix

    ../../modules/nixos/programs/gpg.nix
    ../../modules/nixos/programs/gamemode.nix
    ../../modules/nixos/programs/steam.nix

    ../../modules/nixos/services/fwupd.nix
    ../../modules/nixos/services/openrgb.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/zram-generator.nix
  ];
}
