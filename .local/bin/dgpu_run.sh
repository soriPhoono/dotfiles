#!/bin/bash

# Author: SoriPhoono <soriphoono@gmail.com>
# Description: Run a command on the discrete GPU (NVIDIA SPECIFIC)
# Date: 11-13-23

command="$@"

if [ -z "$command" ]; then
    echo "No command specified"
    exit 1
fi

sh -c "DRI_PRIME=pci-0000_01_00_0 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia $command"
