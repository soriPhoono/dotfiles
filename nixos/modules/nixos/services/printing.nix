{ ... }: {
  services.printing = {
    enable = true;

    cups-pdf.enable = true;
  };
}
