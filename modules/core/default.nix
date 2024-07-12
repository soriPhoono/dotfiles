{ pkgs, ... }: {
  imports = [
    ./nixpkgs.nix
    ./boot.nix
    ./localization.nix
    ./users.nix
  ];

  documentation.dev.enable = true;

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    coreutils
    
    wget
  ];
}
