{ config
, nixosConfig
, inputs
, username
, ...
}: {
  imports = with inputs; [
    sops-nix.homeManagerModules.sops

    ../modules/core
    ../modules/editors

    ../modules/themes/catppuccin.nix
  ];
}
