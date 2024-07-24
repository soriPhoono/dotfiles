{
  description = "SoriPhoono's personal dotfiles";

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        namespace = "soriphoono";

        meta = {
          name = "dotfiles";
          title = "dotfiles";
        };
      };

      channels-config.allowUnfree = true;

      systems = {
        hosts = {
          wsl.modules = with inputs; [
            nixos-wsl.nixosModules.wsl
            {
              wsl = {
                enable = true;
                defaultUser = "soriphoono";
              };
            }
          ];

          zephyrus.modules = with inputs; [
            nixos-hardware.nixosModules.asus-zephyrus-ga401
          ];
        };
      };

      homes = {
        modules = with inputs; [
          stylix.homeManagerModules.stylix
          ags.homeManagerModules.default
          anyrun.homeManagerModules.default
        ];
      };
    };

  inputs = {
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs = {
        hyprland.follows = "hyprland";
        nixpkgs.follows = "nixpkgs";
      };
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
