#!/usr/bin/env bash

run() {
  nextcloud-occ ldap:set-config s01 "$@"
}

nextcloud-occ app:enable files_external
nextcloud-occ files_external:create Jellyfin local null::null -c datadir=/mnt/media/ --output=json
