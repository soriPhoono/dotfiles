{ inputs }:
let
  system = "x86_64-linux";
  stateVersion = "24.05";

  pkgs = import inputs.nixpkgs {
    inherit system;

    overlays = import ../overlays;

    config.allowUnfree = true;
  };
in
{
  wsl =
    let
      inherit system stateVersion;

      vars = {
        defaultUser = "nixos";
        wallpaper_path = ../../assets/wallpapers/1.jpg;
      };
    in
    (import ./wsl {
      inherit system inputs pkgs vars stateVersion;
    });

  zephyrus =
    let
      inherit system stateVersion;

      vars = {
        defaultUser = "soriphoono";
        wallpaper_path = ../../assets/wallpapers/1.jpg;
      };
    in
    (import ./zephyrus {
      inherit system inputs pkgs vars stateVersion;
    });
}
