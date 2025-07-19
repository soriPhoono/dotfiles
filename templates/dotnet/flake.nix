{
  description = "Empty flake with basic devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      with pkgs; {
        formatter = alejandra;

        devShells = mkShell rec {
          dotnetPkg = with dotnetCorePackages;
            combinePackages [
              sdk_7_0
            ];

          deps = [
            zlib
            zlib.dev
            openssl
            dotnetPkg
          ];

          NIX_LD_LIBRARY_PATH = lib.makeLibraryPath ([
              stdenv.cc.cc
            ]
            ++ deps);
          NIX_LD = "${pkgs.stdenv.cc.libc_bin}/bin/ld.so";
          nativeBuildInputs =
            [
            ]
            ++ deps;

          packages = [
          ];

          shellHook = ''
            DOTNET_ROOT="${dotnetPkg}"
          '';
        };
      });
}
