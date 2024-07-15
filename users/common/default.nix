let
  cli = [
    ./core/xdg.nix

    ./programs/git.nix

    ./programs/fish.nix
    ./programs/utils.nix

    ./programs/helix.nix
  ];
in {
  inherit cli;
}
