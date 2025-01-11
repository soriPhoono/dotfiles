{ lib, pkgs, config, ... }:
let
  cfg = config.hardware.amdgpu;
in
{
  options.hardware.amdgpu = {
    enable = lib.mkEnableOption "Enable amdgpu configuration";

    dedicated = lib.mkEnableOption "Enable amdgpu dedicated support";
  };

  config = lib.mkIf cfg.enable {
    hardware.gpu.enable = true;

    environment.variables = lib.mkIf (!cfg.dedicated) {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
    };

    hardware.graphics.extraPackages = with pkgs; lib.mkIf cfg.dedicated [
      rocmPackages.clr.icd
    ];

    systemd.tmpfiles.rules =
      let
        rocmEnv = pkgs.symlinkJoin {
          name = "rocm-combined";
          paths = with pkgs.rocmPackages; [
            rocblas
            hipblas
            clr
          ];
        };
      in
      lib.mkIf cfg.dedicated [
        "L+    /opt/rocm/hip   -    -    -     -    ${rocmEnv}"
      ];
  };
}
