{ lib, config, ... }: {
  options = {
    xbox.enable = lib.mkEnableOption "Enable Xbox controller services";
  };

  config = lib.mkIf config.xbox.enable {
    hardware = {
      xone.enable = true;
      steam-hardware.enable = true;
      uinput.enable = true;
    };
  };
}
