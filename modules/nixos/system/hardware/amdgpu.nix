{
  lib,
  pkgs,
  config,
  virtual,
  ...
}: let
  cfg = config.system.hardware.amdgpu;
in {
  options.system.hardware.amdgpu = {
    integrated.enable = lib.mkEnableOption "Enable integrated GPU features";
    dedicated.enable = lib.mkEnableOption "Enable dedicated GPU features";
  };

  config = lib.mkIf (!virtual && (cfg.integrated.enable || cfg.dedicated.enable)) {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      amdgpu = {
        initrd.enable = cfg.integrated.enable;
        opencl.enable = cfg.dedicated.enable;
      };
    };

    services.xserver.videoDrivers = ["amdgpu"];

    environment = {
      systemPackages = with pkgs; [
        nvtopPackages.full
      ];

      variables = lib.mkIf cfg.integrated.enable {
        LIBVA_DRIVER_NAME = "radeonsi";
        VDPAU_DRIVER = "radeonsi";
      };
    };

    systemd.tmpfiles.rules = lib.mkIf cfg.dedicated.enable [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
