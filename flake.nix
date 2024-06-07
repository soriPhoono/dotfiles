{
  description = "Personal computer configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nixvim = {
      url = "github:nix-community/nixvim";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        nix-darwin.follows = "";
      };
    };
  };

  outputs = inputs: {
    nixosConfigurations = (
      import ./hosts {
        inherit inputs;
      }
    );
  };
}
