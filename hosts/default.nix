{ self, inputs, ... }: {
  flake.nixosConfigurations =
    let
      mkHost =
        { hostname
        , username
        , nixpkgs ? inputs.nixpkgs
        , system ? "x86_64-linux"
        , defaultModules ? true
        , hmEnable ? true
        , extraModules ? [ ]
        ,
        }: nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit self inputs username;
          };

          modules = [
            { networking.hostName = "${hostname}"; }
          ]  ++ nixpkgs.lib.optional defaultModules [

          ] ++ extraModules;
        };
    in
    {
      wsl = mkHost {
        hostname = "wsl";
        username = "soriphoono";

        defaultModules = false;

        extraModules = [
          ./wsl

          inputs.nixos-wsl.nixosModules.default
        ];
      };
    };
}
