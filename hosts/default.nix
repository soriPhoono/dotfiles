{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
in {
  wsl = import ./wsl { inherit lib inputs; };
}
