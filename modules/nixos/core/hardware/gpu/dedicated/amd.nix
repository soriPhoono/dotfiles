{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu.dedicated.amd;
in {
  options.core.hardware.gpu.dedicated.amd.enable = lib.mkEnableOption "Enable  amdgpu driver features for dedicated cards";

  config = lib.mkIf (config.core.hardware.enable && config.core.hardware.gpu.enable && cfg.enable) {
    hardware.amdgpu.opencl.enable = true;

    services.xserver.videoDrivers = ["amdgpu"];

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
