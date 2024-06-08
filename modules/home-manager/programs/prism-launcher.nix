{ pkgs, ... }: {
  home.packages = with pkgs; [
    prismlauncher

    jre8
  ];
}
