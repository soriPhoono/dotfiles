{
  description = "Personal dotfiles for NixOS";

  outputs = { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ ./hosts ./modules/nixos ./modules/homes ];

      perSystem = { pkgs, ... }: {
        formatter = pkgs.nixfmt;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nixd

            nixpkgs-fmt
          ];

          shellHook = ''
            echo "Project - dotfiles"
          '';
        };
      };
    };

  inputs = {
    # Core imports

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # System-specific imports

    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # User environment imports

    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    # Personal inputs

    nvim.url = "github:soriPhoono/nvim";
  };
}
