#!/usr/bin/env bash

sudo systemctl stop docker-nextcloud.service
sudo systemctl stop docker-mariadb.service

sudo rm -rf /mnt/data/nextcloud/
sudo rm -rf /mnt/data/mariadb/

nh os switch .