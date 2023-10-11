{ config, pkgs, ... }:

{
  include = [
    ./hardware.nix # TODO: correct file name
  ];

  boot.loader = {
    systemd-boot = {
      enabled = true;
      consoleMode = "max";
    };
  };

  
}
