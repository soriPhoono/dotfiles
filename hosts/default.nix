{ inputs }: {
  wsl = let
    vars = {
      system = "x86_64-linux";
      stateVersion = "24.05";

      defaultUser = "nixos";
    };

    pkgs = import inputs.nixpkgs {
      inherit (vars) system;

      config.allowUnfree = true;
    };
  in (import ./wsl {
    inherit inputs pkgs vars;
  });

  framework = let
    vars = {
      system = "x86_64-linux";
      stateVersion = "24.05";

      defaultUser = "soriphoono";
    };

    pkgs = import inputs.nixpkgs {
      inherit (vars) system;

      config.allowUnfree = true;
    };
  in (import ./framework {
    inherit inputs pkgs vars;
  });

  zephyrus = let
    vars = {
      system = "x86_64-linux";
      stateVersion = "24.05";

      defaultUser = "soriphoono";
    };

    pkgs = import inputs.nixpkgs {
      inherit (vars) system; 

      config.allowUnfree = true;
    };
  in (import ./zephyrus {
    inherit inputs pkgs vars;
  });
}