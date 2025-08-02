{
  lib,
  config,
  ...
}: let
  cfg = config.server.multimedia;

  dataDir = "/mnt/media/";

  arrStack = [
    "sonarr"
    "radarr"
    "readarr"
    "lidarr"
    "prowlarr"
  ];

  navidromeEndpoint = "https://jukebox.${config.core.networking.tailscale.tn_name}";
  streamingEndpoint = "https://media.${config.core.networking.tailscale.tn_name}";
  pvrEndpoint = "https://pvr.${config.core.networking.tailscale.tn_name}";
  delugeEndpoint = "https://torrent.${config.core.networking.tailscale.tn_name}";
in {
  options.server.multimedia.enable = lib.mkEnableOption "Enable multimedia server";

  config = lib.mkIf cfg.enable {
    server.cloud.enable = true;

    sops.secrets =
      lib.genAttrs
      [
        "server/multimedia/torrent_auth"
      ] (_: {
        mode = "0440";
        inherit (config.services.deluge) group;
        owner = config.services.deluge.user;
      });

    users.groups.multimedia.members = [
      "nextcloud"
      config.services.jellyfin.user
      config.services.deluge.user
      config.services.sonarr.user
      config.services.radarr.user
      config.services.readarr.user
      config.services.lidarr.user
    ];

    systemd = {
      tmpfiles.rules = [
        "d ${dataDir} 0777 ${config.services.deluge.user} multimedia -"
        "d ${dataDir}/Shows/ 0777 ${config.services.deluge.user} multimedia -"
        "d ${dataDir}/Movies/ 0777 ${config.services.deluge.user} multimedia -"
        "d ${dataDir}/Music/ 0777 ${config.services.deluge.user} multimedia -"
        "d ${dataDir}/Books/ 0777 ${config.services.deluge.user} multimedia -"
        "d ${dataDir}/Torrent/ 0777 ${config.services.deluge.user} multimedia -"
      ];

      services = let
        requires = args: {
          wants = args;
          after = args;
        };
      in
        (lib.genAttrs [
            "navidrome"
            "jellyfin"
            "deluge"
          ] (
            _:
              requires [
                "systemd-tmpfiles-setup.service"
                "systemd-tmpfiles-resetup.service"
              ]
          ))
        // (lib.genAttrs arrStack (_:
          requires [
            "deluge.service"
          ]));
    };

    services = {
      deluge = {
        enable = true;
        web.enable = true;
        dataDir = "${dataDir}/Torrent";
        declarative = true;
        group = "multimedia";
        config = {
          enabled_plugins = ["Label"];
          stop_seed_ratio = 0;
          stop_seed_at_ratio = true;
          remove_seed_at_ratio = true;
          seed_time_limit = 0;
          seed_time_ratio_limit = 0;
          max_active_seeding = 1;
        };
        authFile = config.sops.secrets."server/multimedia/torrent_auth".path;
      };

      prowlarr = {
        enable = true;
        settings.server.urlbase = "/index/";
      };

      sonarr = {
        enable = true;
        settings.server.urlbase = "/shows/";
      };

      radarr = {
        enable = true;
        settings.server.urlbase = "/movies/";
      };

      lidarr = {
        enable = true;
        settings.server.urlbase = "/music/";
      };

      readarr = {
        enable = true;
        settings.server.urlbase = "/books/";
      };

      navidrome = {
        enable = true;

        settings = {
          MusicFolder = dataDir + "/Music";
        };
      };

      jellyseerr.enable = true;

      jellyfin = {
        enable = true;

        user = "jellyfin";
        group = "jellyfin";
      };

      caddy.virtualHosts = {
        ${delugeEndpoint} = {
          extraConfig = ''
            bind tailscale/torrent

            reverse_proxy localhost:${builtins.toString config.services.deluge.web.port}
          '';
        };

        ${pvrEndpoint} = {
          extraConfig = ''
            bind tailscale/pvr

            redir /index /index/
            redir /shows /shows/
            redir /movies /movies/
            redir /music /music/
            redir /books /books/

            reverse_proxy /index/* localhost:${builtins.toString config.services.prowlarr.settings.server.port}
            reverse_proxy /shows/* localhost:${builtins.toString config.services.sonarr.settings.server.port}
            reverse_proxy /movies/* localhost:${builtins.toString config.services.radarr.settings.server.port}
            reverse_proxy /music/* localhost:${builtins.toString config.services.lidarr.settings.server.port}
            reverse_proxy /books/* localhost:${builtins.toString config.services.readarr.settings.server.port}
            reverse_proxy localhost:${builtins.toString config.services.jellyseerr.port}
          '';
        };

        ${navidromeEndpoint} = {
          extraConfig = ''
            bind tailscale/jukebox
            reverse_proxy localhost:${builtins.toString config.services.navidrome.settings.Port}
          '';
        };

        ${streamingEndpoint} = {
          extraConfig = ''
            bind tailscale/media
            reverse_proxy localhost:8096
          '';
        };
      };

      homepage-dashboard = {
        settings = {
          layout = {
            Media = {
              style = "row";
              columns = 3;
            };
          };
        };
        services = [
          {
            Media = [
              {
                JellyFin = {
                  description = "JellyFin media server";
                  href = streamingEndpoint;
                  icon = "sh-jellyfin";
                  widget = {
                    type = "jellyfin";
                    url = "http://localhost:8096";
                    key = "f28a1a6c712d4cdbad99906fe075f983";
                  };
                };
              }
              {
                Navidrome = {
                  description = "Music streaming client";
                  href = navidromeEndpoint;
                  icon = "sh-navidrome";
                  widget = {
                    type = "navidrome";
                    url = "http://localhost:${builtins.toString config.services.navidrome.settings.Port}";
                    user = "admin";
                    token = "a709718471cc14e22fb4ebc230808e9e";
                    salt = "helloworld";
                  };
                };
              }
              {
                PVR = {
                  description = "Personal virtual recorder (request engine)";
                  href = pvrEndpoint;
                  icon = "sh-radarr";
                };
              }
              {
                Deluge = {
                  description = "Torrent download manager";
                  href = delugeEndpoint;
                  icon = "sh-deluge";
                  widget = {
                    type = "deluge";
                    url = "http://localhost:${builtins.toString config.services.deluge.web.port}";
                    password = "deluge";
                  };
                };
              }
            ];
          }
        ];
      };
    };
  };
}
