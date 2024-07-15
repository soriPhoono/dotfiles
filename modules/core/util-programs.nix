{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  programs.dconf.enable = true;
}
