{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;

  vars = {
    defaultUser = "soriphoono";

    wallpaperPath = ../assets/wallpapers/2.jpg;
  };
in {
  wsl = import ./wsl { inherit lib inputs vars; };
}
