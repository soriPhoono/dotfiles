{ pkgs, ... }: {
  home.packages = with pkgs; [
    protontricks # TODO: check package name
  ];
}
