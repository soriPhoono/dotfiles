{ lib, pkgs, config, virtual, ... }:
let
  cfg = config.system.hardware.amdgpu;
in
{
  options.system.hardware.amdgpu = {
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

    environment = {
      systemPackages = with pkgs; [
        nvtop
      ];

      variables = lib.mkIf (cfg.dedicated.enable && cfg.dedicated.acceleration) {
        LIBVA_DRIVER_NAME = "radeonsi";
        VDPAU_DRIVER = "radeonsi";
      };
    };

    systemd.tmpfiles.rules = lib.mkIf (cfg.dedicated.enable && cfg.dedicated.rocm) [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
