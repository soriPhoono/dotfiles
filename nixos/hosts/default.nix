{ inputs }:
let
  vars = {
    system = "x86_64-linux";
    stateVersion = "24.05";

    defaultUser = "soriphoono";
    wallpaper_path = ../../assets/wallpapers/1.jpg;
  };

  pkgs = import inputs.nixpkgs {
    inherit (vars) system;

    overlays = import ../overlays;

    config.allowUnfree = true;
  };

  pkgs-stable = import inputs.nixpkgs-stable {
    inherit (vars) system;

    overlays = import ../overlays;

    config.allowUnfree = true;
  };
in {
  zephyrus = let inherit (vars) system;
  in import ./zephyrus { inherit system inputs pkgs pkgs-stable vars; };

  home-desktop = let inherit (vars) system;
  in import ./home-desktop { inherit system inputs pkgs pkgs-stable vars; };
}
