{
  programs.bash = {
    enable = true;

    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" "ignoreboth" ];
  };
}
