{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  programs.dconf.enable = true;

  programs.nix-index-database.comma.enable = true;
}
