# TODO: enable low latency for gaming, make sure discord calls still work

{ ... }: {
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    pulse.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    jack.enable = true;
  };
}