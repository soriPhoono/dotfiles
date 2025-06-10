{
  lib,
  config,
  ...
}: let
  cfg = config.server.multimedia;

  serviceDir = "/services/jellyfin/";
  dataDir = "/mnt/media";

  arrStack = [
    "sonarr"
    "radarr"
    "bazarr"
    "readarr"
    "lidarr"
    "prowlarr"
  ];

  navidromeEndpoint = "https://jukebox.${config.core.networking.tailscale.tn_name}";
  streamingEndpoint = "https://media.${config.core.networking.tailscale.tn_name}";
  delugeEndpoint = "https://torrent.${config.core.networking.tailscale.tn_name}";
  sonarrEndpoint = "https://shows.${config.core.networking.tailscale.tn_name}";
  radarrEndpoint = "https://movies.${config.core.networking.tailscale.tn_name}";
  bazzarEndpoint = "https://subtitles.${config.core.networking.tailscale.tn_name}";
  prowlarrEndpoint = "https://media-manager.${config.core.networking.tailscale.tn_name}";
  readarrEndpoint = "https://books.${config.core.networking.tailscale.tn_name}";
  lidarrEndpoint = "https://music.${config.core.networking.tailscale.tn_name}";
in {
  options.server.multimedia.enable = lib.mkEnableOption "Enable multimedia server";

  config = lib.mkIf cfg.enable {
    server.nextcloud.enable = true;

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
      config.services.bazarr.user
      config.services.readarr.user
      config.services.lidarr.user
    ];

    systemd = {
      tmpfiles.rules = [
        "d ${serviceDir} 0770 ${config.services.jellyfin.user} ${config.services.jellyfin.group} -"
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
            "jellyfin"
            "deluge"
          ] (
            _:
              requires [
                "openldap.service"
                "systemd-tmpfiles-setup.service"
                "systemd-tmpfiles-resetup.service"
              ]
          ))
        // (lib.genAttrs arrStack (_:
          requires [
            "deluge.service"
          ]));
    };

    services =
      (lib.genAttrs arrStack (_: {
        enable = true;
      }))
      // {
        navidrome = {
          enable = true;

          settings = {
            MusicFolder = "/mnt/media/Music";
          };
        };

        jellyfin = {
          enable = true;

          cacheDir = serviceDir + "/cache/";
          dataDir = serviceDir;
        };

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

        caddy.virtualHosts = {
          ${delugeEndpoint} = {
            extraConfig = ''
              bind tailscale/torrent

              route {
                rewrite /torrent /
                reverse_proxy localhost:${builtins.toString config.services.deluge.web.port}
              }
            '';
          };

          ${sonarrEndpoint} = {
            extraConfig = ''
              bind tailscale/shows
              reverse_proxy localhost:${builtins.toString config.services.sonarr.settings.server.port}
            '';
          };

          ${radarrEndpoint} = {
            extraConfig = ''
              bind tailscale/movies
              reverse_proxy localhost:${builtins.toString config.services.radarr.settings.server.port}
            '';
          };

          ${lidarrEndpoint} = {
            extraConfig = ''
              bind tailscale/music
              reverse_proxy localhost:${builtins.toString config.services.lidarr.settings.server.port}
            '';
          };

          ${bazzarEndpoint} = {
            extraConfig = ''
              bind tailscale/subtitles
              reverse_proxy localhost:${builtins.toString config.services.bazarr.listenPort}
            '';
          };

          ${readarrEndpoint} = {
            extraConfig = ''
              bind tailscale/books
              reverse_proxy localhost:${builtins.toString config.services.readarr.settings.server.port}
            '';
          };

          ${prowlarrEndpoint} = {
            extraConfig = ''
              bind tailscale/media-manager
              reverse_proxy localhost:${builtins.toString config.services.prowlarr.settings.server.port}
            '';
          };

          ${navidromeEndpoint} = {
            extraConfig = ''
              bind tailscale/jukebox
              reverse_proxy localhost:${builtins.toString config.services.navidrome.settings.Port}
            '';
          };

          "pvr.${config.core.networking.tailscale.tn_name}" = {
            extraConfig = ''
              bind tailscale/pvr

              reverse_proxy /torrent localhost:${builtins.toString config.services.deluge.web.port}
            '';
          };

          ${streamingEndpoint} = {
            extraConfig = ''
              bind tailscale/media
              reverse_proxy localhost:8096
            '';
          };
        };

        homepage-dashboard.services = [
          {
            "Media" = [
              {
                Deluge = {
                  description = "Torrent manager";
                  href = delugeEndpoint;
                };
              }
              {
                Prowlarr = {
                  description = "Indexer manager for torrent automation";
                  href = prowlarrEndpoint;
                };
              }
              {
                Sonarr = {
                  description = "TV manager for torrent automation";
                  href = sonarrEndpoint;
                };
              }
              {
                Radarr = {
                  description = "Movies manager for torrent automation";
                  href = radarrEndpoint;
                };
              }
              {
                Bazarr = {
                  description = "Subtitles manager for torrent automation";
                  href = bazzarEndpoint;
                };
              }
              {
                Readarr = {
                  description = "E-Book manager for torrent automation";
                  href = readarrEndpoint;
                };
              }
              {
                Lidarr = {
                  description = "Music manager for torrent automation";
                  href = lidarrEndpoint;
                };
              }
              {
                Navidrome = {
                  description = "Music streaming client";
                  href = navidromeEndpoint;
                };
              }
              {
                JellyFin = {
                  description = "JellyFin media server";
                  href = streamingEndpoint;
                };
              }
            ];
          }
        ];
      };
  };
}
