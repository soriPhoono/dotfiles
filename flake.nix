{
  description = "Personal NixOS configurations for my personal computers/home-server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager, nur, nixvim, hyprland, ... }:
    let
      vars = {
        user = "soriphoono";
        location = "$HOME/.dotfiles";
        terminal = "alacritty";
        editor = "nvim";
      };
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixos-hardware home-manager nur nixvim hyprland vars;
        }
      );

      homeConfigurations = (
        import ./home {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager vars;
        }
      );
    };
}
