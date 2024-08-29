{ lib
, pkgs
, config
, username
, ...
}:
let cfg = config.desktop;
in {
  imports = [
    ./hyprland.nix

    ./gaming.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Enable desktop support";
  };

  config = lib.mkIf cfg.enable {
    pipewire = {
      enable = true;

      jack.enable = true;
      alsa.enable = true;
      alsa.enable32Bit = true;
      pulse.enable = true;
    };

    networking.networkmanager.enable = true;

    users.users.${username}.extraGroups = [
      "networkmanager"
    ];
  };
}
