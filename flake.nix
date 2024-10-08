{
  description = "Personal dotfiles for NixOS";

  outputs = { nixpkgs, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ ./hosts ./modules ./homes/modules ];

      perSystem = { pkgs, ... }: { 
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nil
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

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    ags.url = "github:Aylur/ags";
    stylix.url = "github:danth/stylix";

    # Development environment imports

    neovim.url = "github:soriPhoono/nvim";
  };
}
