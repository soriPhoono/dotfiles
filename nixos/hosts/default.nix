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

  home-desktop =
    let
      inherit system stateVersion;

      vars = {
        defaultUser = "soriphoono";
        wallpaper_path = ../../assets/wallpapers/1.jpg;
      };
    in
    (import ./home-desktop {
      inherit system inputs pkgs vars stateVersion;
    });
}
