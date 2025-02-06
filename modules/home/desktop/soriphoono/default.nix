{lib, ...}: {
  imports = [
    ./mako.nix
    ./wofi.nix
    ./kitty.nix

    ./hyprland
  ];

  options.desktop.soriphoono = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";
  };
}
