{ pkgs, ... }: {
  imports = [
    ./nixpkgs.nix
    ./boot.nix
    ./localization.nix
    ./users.nix
    ./networking.nix
  ];

  documentation.dev.enable = true;

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  programs.nix-index-database.comma.enable = true;

}
