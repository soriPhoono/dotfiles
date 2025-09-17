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
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    programs.virt-manager = {
      enable = true;
    };

    networking.firewall.trustedInterfaces = [
      "virbr0"
    ];

    users.extraUsers =
      builtins.mapAttrs (_: _: {
        extraGroups = [
          "libvirtd"
        ];
      })
      config.core.users;
  };
}
