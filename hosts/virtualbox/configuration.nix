{ vars, ... }: {
  imports = [
    ../../modules/nixos/boot
    ../../modules/nixos/core

    ../../modules/nixos/programs/gpg.nix
    ../../modules/nixos/programs/gamemode.nix
    ../../modules/nixos/programs/steam.nix

    ../../modules/nixos/desktops/kde.nix
  ];

  system.stateVersion = "${vars.stateVersion}";
}
