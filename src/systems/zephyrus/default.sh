#!/usr/bin/env bash

sh ./src/drivers/integrated_gpu/amd.sh
sh ./src/drivers/dedicated_gpu/nvidia.sh

sh ./src/lib/default.sh
