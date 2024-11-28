{ lib, config, ... }: 
let cfg = config.cli.hardware.graphics.amdgpu;
in {
  options.cli.hardware.graphics.amdgpu = {
    enable = lib.mkEnableOption "Enable AMD GPU support";
    dedicated = lib.mkEnableOption "Enable dedicated AMD GPU support";
  };

  config.hardware.amdgpu = {
    initrd.enable = true;

    opencl.enable = lib.mkIf cfg.dedicated true;
  };
}