{ pkgs }: {
  # Nix development shell

  default = pkgs.mkShell {
    name = "startup";

    packages = with pkgs; [
      nil
      nixpkgs-fmt
    ];

    shellHook = ''
      fish && exit
    '';
  };
}
