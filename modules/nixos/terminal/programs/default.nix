{ lib, pkgs, config, ... }:
let cfg = config.terminal.programs;
in {
  options = {
    terminal.programs.enable = lib.mkEnableOption "Enable terminal programs";
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
  };
}
