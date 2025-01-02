{ lib, pkgs, config, ... }:
let
  cfg = config.hardware.amdgpu;
in
{
  options.hardware.amdgpu = {
    enable = lib.mkEnableOption "Enable amdgpu configuration";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
