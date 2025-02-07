{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    git
  ];

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    registry = lib.mapAttrs (_: v: {flake = v;}) flakeInputs;

    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];

      accept-flake-config = false;
    };
  };
}
