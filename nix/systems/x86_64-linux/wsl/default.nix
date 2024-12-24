{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
  ];

  themes.catppuccin.enable = true;

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
