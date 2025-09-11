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
      enableExtensionPack = true;
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
