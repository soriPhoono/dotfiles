{ lib, config, ... }:
let
  cfg = config.system.hardware;
in {
  imports = [
    ./intelgpu.nix
    ./amdgpu.nix

    ./bluetooth.nix
  ];
}
