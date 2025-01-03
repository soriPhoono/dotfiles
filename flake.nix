{
  description = "Description for the project";

  inputs = {
    # Repo dependencies
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Framework dependencies
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System dependencies
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # System dependencies

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

    nvim.url = "github:soriphoono/nvim";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;

      snowfall = {
        namespace = "soriphoono";

        meta = {
          name = "dotfiles";

          title = "Personal dotfiles";
        };
      };
    };
}
