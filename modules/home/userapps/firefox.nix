{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.firefox;
in {
  options.userapps.firefox.enable = lib.mkEnableOption "Enable Firefox";

  config = lib.mkIf cfg.enable {
    home.file.".mozilla/firefox/default/search.json.mozlz4".force = lib.mkForce true;

    programs = {
      librewolf = let
        ff-ultima = pkgs.fetchFromGitHub {
          owner = "soulhotel";
          repo = "FF-ULTIMA";
          rev = "db84254";
          sha256 = "sha256-z1R0OXJYbJd3G+ncWmp44uYJFaZtZ1Qzz8TbaHZ6BBQ=";
        };
      in {
        enable = true;

        profiles.default = {
          id = 0;
          name = "default";
          isDefault = true;

          search = {
            force = true;

            order = ["ddg"];

            default = "ddg";

            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@np"];
              };

              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@no"];
              };

              "NixOS Wiki" = {
                urls = [
                  {
                    template = "https://wiki.nixos.org/w/index.php";
                    params = [
                      {
                        name = "search";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@nw"];
              };

              "google".metaData.hidden = true;
              "bing".metaData.hidden = true;
            };
          };

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            privacy-badger
            bitwarden
          ];

          settings = {
            extensions.autoDisableScopes = 0;
            browser = {
              search = {
                defaultenginename = "DuckDuckGo";
                "order.1" = "DuckDuckGo";
              };
            };
          };

          extraConfig = builtins.readFile (ff-ultima + "/user.js");
          userChrome = builtins.readFile (ff-ultima + "/userChrome.css");
          userContent = builtins.readFile (ff-ultima + "/userContent.css");
        };

        policies = {
          DisableTelementry = true;
          DisplayBookmarksToolbar = "never";
        };
      };
    };

    services = {
      psd = {
        enable = true;
        resyncTimer = "10m";
      };
    };
  };
}
