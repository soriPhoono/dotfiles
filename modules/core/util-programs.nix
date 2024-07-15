{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  programs.fish.enable = true;
}
