{ lib, ... }: {
  services.pipewire = {
    enable = true;
    audio.enable = true;

    jack.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
  };

  hardware.pulseaudio.enable = lib.mkForce false;
}
