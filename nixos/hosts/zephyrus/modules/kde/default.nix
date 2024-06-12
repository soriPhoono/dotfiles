{ inputs, ... }: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager

    ../../../../modules/home-manager/programs/bat.nix
    ../../../../modules/home-manager/programs/development-deps.nix
    ../../../../modules/home-manager/programs/eza.nix
    ../../../../modules/home-manager/programs/fastfetch.nix
    ../../../../modules/home-manager/programs/fish.nix
    ../../../../modules/home-manager/programs/gaming.nix
    ../../../../modules/home-manager/programs/git.nix
    ../../../../modules/home-manager/programs/nvim.nix
    ../../../../modules/home-manager/programs/vscode.nix
    ../../../../modules/home-manager/programs/yt-dlp.nix

    ../../../../modules/home-manager/services/mpris-proxy.nix
  ];
}
