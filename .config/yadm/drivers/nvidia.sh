#!/bin/bash

# Path:         ~/.config/yadm/drivers/bootstrap

# Description:  Install gpu drivers, cpu microcode, and other hardware related packages

gpus_installed=$(lspci | grep -e "3D" -e "VGA")
gpu_count=$(grep "" -c <<<"$gpus_installed")

if [ gpu_count -gt 0 ] && [ gpu_count -lt 2 ]; then
    for gpu in "$gpus_installed"; do
        case "$gpu" in
        "*NVIDIA*")
            source "$HOME/.config/yadm/drivers/nvidia.sh"
            ;;

        "*AMD*")
            source "$HOME/.config/yadm/drivers/amd.sh"
            ;;

        "*Intel*")
            source "$HOME/.config/yadm/drivers/intel.sh"
            ;;
        esac
    done
fi
