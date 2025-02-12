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

    packages = with pkgs; [
      nixd

      sbctl

      age
      ssh-to-age
      sops

      disko
      nixos-anywhere
    ];

    buildInputs = pre-commit-check.enabledPackages;
  }
