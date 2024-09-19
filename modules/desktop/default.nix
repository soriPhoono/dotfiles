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
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Enable desktop support";
  };

  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;

      jack.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    networking.networkmanager.enable = true;

    users.users.${username}.extraGroups = [
      "networkmanager"
    ];
  };
}
