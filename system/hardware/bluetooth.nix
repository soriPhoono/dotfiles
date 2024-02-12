# TODO: Needs testing

{ ... }: {
  hardware.bluetooth = {
    enable = true;

    settings = {
      # Enable Xbox One controller support
      General = {
        Class = "0x000100";
        ControllerMode = "bredr";
        FastConnectable = true;
        JustWorksRepairing = "always";
        Privacy = "device";
        # Battery info for Bluetooth devices
        Experimental = true;
      };
    };
  };

  # https://github.com/NixOS/nixpkgs/issues/114222
  systemd.user.services.telephony_client.enable = false;
}
