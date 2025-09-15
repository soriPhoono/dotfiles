{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.features.virtualisation;
in {
  options.desktop.features.virtualisation = {
    enable = lib.mkEnableOption "Enable virtualbox";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      enableKvm = true;
      addNetworkInterface = lib.mkForce false;
    };

    programs.virt-manager = {
      enable = true;
    };

    users.extraUsers =
      builtins.mapAttrs (_: _: {
        extraGroups = [
          "vboxusers"
        ];
      })
      config.core.users;
  };
}
