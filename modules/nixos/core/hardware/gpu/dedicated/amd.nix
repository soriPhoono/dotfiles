{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware.gpu.dedicated.amd;
in {
  options.${namespace}.core.hardware.gpu.dedicated.amd.enable = lib.mkEnableOption "Enable  amdgpu driver features for dedicated cards";

  config = lib.mkIf cfg.enable {
    ${namespace}.core.hardware.gpu.enable = true;

    hardware.amdgpu.opencl.enable = true;

    services.xserver.videoDrivers = ["amdgpu"];

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
