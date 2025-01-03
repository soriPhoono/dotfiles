{ pkgs, ... }: {
  hardware = {
    intel.enable = true;

    amdgpu = {
      enable = true;
      dedicated = true;
    };
  };

  themes.catppuccin.enable = true;
}
