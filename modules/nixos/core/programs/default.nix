{ lib, pkgs, config, ... }:
let cfg = config.core.programs;
in {
  options = {
    core.programs.enable = lib.mkEnableOption "Enable core programs";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvtopPackages.full

      libva-utils
      vdpauinfo
      clinfo
      glxinfo
      vulkan-tools

      unzip
      p7zip
      unrar
    ];

    programs = {
      usbtop.enable = true;
    };

    programs.corectrl.enable = true;
  };
}
