{ pkgs, ... }: {
  imports = [
    <home-manager/nixos>

    # Import user configurations for various users on system
    ./soriphoono.nix
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
}
