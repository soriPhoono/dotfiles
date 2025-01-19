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
    ];

    sopsCreateGPGHome = true;

    buildInputs =
      pre-commit-check.enabledPackages
      ++ [
        (pkgs.callPackage inputs.sops-nix {}).sops-import-keys-hook
      ];
  }
