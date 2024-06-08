{ pkgs, vars, ... }: {
  imports = [
    ../../modules/nixos/boot
    ../../modules/nixos/core

    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/opengl.nix
    ../../modules/nixos/hardware/xbox.nix

    ../../modules/nixos/programs/gpg.nix
    ../../modules/nixos/programs/wine.nix
    ../../modules/nixos/programs/gamemode.nix
    ../../modules/nixos/programs/prism-launcher.nix
    ../../modules/nixos/programs/steam.nix

    ../../modules/nixos/services/fwupd.nix
    ../../modules/nixos/services/openrgb.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/zram-generator.nix
  ];

  environment.systemPackages = with pkgs; [
    man
    man-pages
    nix-tree

    wget
  ];

  programs.nano.enable = true;

  users = {
    defaultUserShell = pkgs.fish;
    users = {
      root.ignoreShellProgramCheck = true;
      ${vars.defaultUser}.ignoreShellProgramCheck = true;
    };
  };

  nix = {
    package = pkgs.nix;

    settings = {
      auto-optimise-store = true;
    };

    optimise = {
      dates = [
        "daily"
      ];
      automatic = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
}
