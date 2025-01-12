{ lib, pkgs, config, ... }:
let
  this = "system.hardware.gpu.amd";

  cfg = config."${this}";
in
{
  options."${this}" = {
    integrated = {
      enable = lib.mkEnableOption "Enable integrated GPU features";
    };

    dedicated = {
      enable = lib.mkEnableOption "Enable dedicated GPU features";

      acceleration = lib.mkOption {
        type = lib.types.bool;
        description = "Enable hardware acceleration features on amd gpus";

        default = true;
      };

      rocm = lib.mkOption {
        type = lib.types.bool;
        description = "Enable ROCm support on AMD GPUs";

        default = true;
      };
    };
  };

  config = {
    environment.variables = lib.mkIf (cfg.dedicated.enable && cfg.dedicated.acceleration) {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
    };

    hardware.amdgpu = {
      initrd.enable = lib.mkIf cfg.integrated.enable;
      opencl.enable = lib.mkIf cfg.dedicated.enable;
    };

    systemd.tmpfiles.rules = lib.mkIf (cfg.dedicated.enable && cfg.dedicated.rocm) [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
