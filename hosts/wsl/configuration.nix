{ pkgs, ... }: {
  imports = [
    ../../modules/nixos/core/core.nix
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
