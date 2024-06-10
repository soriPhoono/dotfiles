{ inputs }: let
  vars = {
    stateVersion = "24.05";
    system = "x86_64-linux";

    defaultUser = "nixos";

    wallpaper_path = "~/Pictures/wallpapers/2.jpg";
  };

  pkgs = import inputs.nixpkgs {
    inherit (vars) system;

    overlays = import ../overlays;

    config.allowUnfree = true;
  };
in {
  wsl = (import ./wsl {
    inherit inputs pkgs vars;
  });

  zephyrus = (import ./zephyrus {
    inherit inputs pkgs vars;
  });
}
