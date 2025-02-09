{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.system.boot;
in {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options.system.boot = {
    enable = lib.mkEnableOption "Enable boot configuration";

    secure-boot.enable = lib.mkEnableOption "Enable secure boot based kernel";

    plymouth.enable = lib.mkEnableOption "Enable Plymouth boot splash screen";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelParams =
        if (!cfg.plymouth.enable)
        then [
        ]
        else [
          "quiet"
          "systemd.show_status=false"
          "udev.log_level=3"
        ];

      initrd.verbose = !cfg.plymouth.enable;

      consoleLogLevel =
        if (!cfg.plymouth.enable)
        then 4
        else 0;

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot.enable = lib.mkForce (!cfg.secure-boot.enable);
      };

      lanzaboote = {
        inherit (cfg.secure-boot) enable;
        pkiBundle = "/var/lib/sbctl";
      };

      plymouth.enable = cfg.plymouth.enable;
    };

    zramSwap.enable = true;

    environment.persistence."/persist".directories = lib.mkIf cfg.secure-boot.enable [
      "/var/lib/sbctl"
    ];
  };
}
