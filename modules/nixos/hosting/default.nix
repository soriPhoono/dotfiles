{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./docker.nix
    ./podman.nix

    ./kubernetes/single-node.nix
    ./kubernetes/multi-node-leader.nix
    ./kubernetes/multi-node-worker.nix
  ];
}
