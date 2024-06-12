{ pkgs, ... }: {
  imports = [
    ../../modules/nixos/core/core.nix
  ];

  environment.systemPackages = with pkgs; [
    nil
    nixpkgs-fmt
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
