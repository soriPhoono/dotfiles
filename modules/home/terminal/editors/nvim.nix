{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;

    clipboard.providers.wl-copy.enable = true;
    colorschemes.catppuccin.enable = true;


  }
}
