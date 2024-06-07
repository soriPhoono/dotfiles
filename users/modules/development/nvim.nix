{ inputs, ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    enableMan = true;
    
    colorscheme.catppuccin.enable = true;
  }; 
}