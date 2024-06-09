{ vars, ... }: {
  imports = [
    ../../modules/nixos/boot
    ../../modules/nixos/core

    ../../modules/nixos/programs/gpg.nix
    ../../modules/nixos/programs/steam.nix

    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/zram-generator.nix
  ];

  virtualisation.virtualbox.guest = {
    enable = true;
    seamless = true;
    clipboard = true;
    dragAndDrop = true;
  };

  system.stateVersion = "${vars.stateVersion}";
}
