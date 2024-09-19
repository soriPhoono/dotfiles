final: prev: {
  firefox = prev.wrapFirefox (prev.firefox-unwrapped.override { pipewireSupport = true; }) { };
}
