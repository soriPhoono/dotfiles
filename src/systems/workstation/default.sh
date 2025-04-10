#!/usr/bin/env bash

source ./util/default.sh

sh ./drivers/integrated_gpu/intel.sh
sh ./drivers/dedicated_gpu/amd.sh
sh ./drivers/hid/xbox.sh

install_packages steam solaar

sudo cp -r ./systems/workstation/root/* /
