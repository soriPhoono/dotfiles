{ lib, pkgs, config, ... }:
let cfg = config.terminal.programs.system;
in {
  options = {
    terminal.programs.system.enable = lib.mkEnableOption "Enable system programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libva-utils
      vdpauinfo
      clinfo
      glxinfo
      vulkan-tools

      unzip
      p7zip
      unrar
    ];

    home.shellAliases = with pkgs; {
      df = "${duf}/bin/duf";
      du = "${dua}/bin/dua i";

      top = "${btop}/bin/btop";
      gtop = "${nvtopPackages.full}/bin/nvtop";
    };
  };
}
