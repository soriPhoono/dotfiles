{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.browsers.librewolf;
in {
  options.userapps.browsers.librewolf.enable = lib.mkEnableOption "Enable Firefox";

  config = lib.mkIf cfg.enable {
    programs = {
      librewolf = {
        enable = true;
        package = pkgs.librewolf-bin;

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
        };

        policies = {
          DisableTelementry = true;
          DisplayBookmarksToolbar = "never";
        };
      };
    };
  };
}
