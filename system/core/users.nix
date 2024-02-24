{ config, pkgs, ... }: {
  users.users.soriphoono = {
    isNormalUser = true;
    description = "Sori Phoono";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      firefox
    ];
  };
}
