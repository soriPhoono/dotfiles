{lib, ...}: {
  imports = [
    ./mako.nix
    ./fuzzel.nix
    ./kitty.nix

    ./hyprland
  ];

  options.desktop.soriphoono = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";
  };
}
