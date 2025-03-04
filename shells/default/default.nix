{
  inputs,
  pkgs,
  ...
}: let
  pre-commit-check = import ../../checks/pre-commit-checks {
    inherit inputs;
    inherit (pkgs) system;
  };
in
  pkgs.mkShell {
    inherit (pre-commit-check) shellHook;

    RUST_MIN_STACK = 16777216;

    packages = with pkgs; [
      nixos-facter

      age
      ssh-to-age
      sops
    ];

    buildInputs = pre-commit-check.enabledPackages;
  }
