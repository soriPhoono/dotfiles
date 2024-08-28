{ config
, nixosConfig
, inputs
, lib
, username
, ...
}: {
  imports = with inputs; [
    sops-nix.homeManagerModules.sops

    ../modules/core
    ../modules/editors

    ../modules/themes/catppuccin.nix
  ] ++ lib.optionals nixosConfig.desktop.enable [
    ../modules/hyprland
  ];
}
