{ config, ... }: {
  programs.zellij = {
    enable = true;
    
    enableFishIntegration = true;

    settings = {
      
    };
  };
}
