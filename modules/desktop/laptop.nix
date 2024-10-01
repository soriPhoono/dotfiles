{ lib, config, ... }:
let cfg = config.desktop.laptop;
in {
  options = {
    desktop.laptop.enable = lib.mkEnableOption "Enable laptop modifications";
  };

  config = lib.mkIf cfg.enable {
    services.logind.extraConfig = ''
      HandlePowerKey=ignore
      HandleLidSwitch=suspend
      HandleLidSwitchExternalPower=ignore
    '';
  };
}
