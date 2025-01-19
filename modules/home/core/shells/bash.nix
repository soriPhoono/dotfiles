{config, ...}: {
  programs.bash = {
    enable = true;

    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = ["erasedups" "ignoreboth"];

    initExtra = ''
      export $(cat ${config.sops.secrets.environment.path} | xargs)
    '';
  };
}
