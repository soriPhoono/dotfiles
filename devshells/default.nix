{ pkgs }:
{
  # Nix development shell

  default = {
    name = "nix";
    motd = ''
      Welcome to the devshell!
    '';

    packages = with pkgs; [
      nil
      nixpkgs-fmt
    ];
  };
}