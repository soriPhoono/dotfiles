{ inputs }: {
  wsl = let
    vars = {
      system = "x86_64-linux";
      stateVersion = "24.05";

      defaultUser = "nixos";
    };

    pkgs = import inputs.nixpkgs {
      inherit (vars) system;

      overlays = ../overlays;

      config.allowUnfree = true;
    };
  in (import ./wsl {
    inherit inputs pkgs vars;
  });

  virtualbox = let
    vars = {
      system = "x86_64-linux";
      stateVersion = "24.05";

      defaultUser = "soriphoono";
    };

    pkgs = import inputs.nixpkgs {
      inherit (vars) system;

      overlays = ../overlays;

      config.allowUnfree = true;
    };
  in (import ./virtualbox {
    inherit inputs pkgs vars;
  });
}