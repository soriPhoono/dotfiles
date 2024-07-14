{ pkgs, ... }: {
  wsl.enable = true;
  wsl.defaultUser = "soriphoono";

  programs.nix-ld = {
    enable = true;

    package = pkgs.nix-ld-rs;
  };
}
