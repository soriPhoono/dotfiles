{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./fish.nix

    ./direnv.nix
    ./starship.nix
    ./fastfetch.nix
    ./fd.nix
    ./eza.nix
    ./git.nix
    ./ripgrep.nix
    ./nix-index.nix
    ./helix.nix
  ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  cli.fish.extraShellInit = "${pkgs.fastfetch}/bin/fastfetch";

  home.stateVersion = "24.11";
}
