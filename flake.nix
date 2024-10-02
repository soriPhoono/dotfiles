{
  description = "Personal dotfiles for NixOS";

  outputs = { nixpkgs, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ ./hosts ./modules ./homes/modules ];

      perSystem = { pkgs, ... }: { formatter = pkgs.nixpkgs-fmt; };
    };

  inputs = {
    # Core imports

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # System-global imports

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System-specific imports

    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # User environment imports

    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    stylix.url = "github:danth/stylix";
    ags = {
      url = "github:Aylur/ags";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Development environment imports

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
