function install_drivers() {
    source "$ROOT_DIR/core/util.sh"

    print_header "GPU Drivers"

    if [[ $(systemd-detect-virt) -ne "none" ]]; then
        print_warning "Virtual machine detected, skipping GPU driver installation"
        return 0
    fi

    gpus_installed=$(lspci | grep -e "VGA" -e "3D")
    # ensure there are GPUs installed, and no more than 2
    if [[ -z "$gpus_installed" || $(echo "$gpus_installed" | wc -l) -gt 2 ]]; then
        print_warning "Bad GPU configuration detected, skipping GPU driver installation"
        return 0
    fi

    confirm "Install GPU drivers (nvidia, amd, intel)? Please check the readme, this is rather complicated!" "n"
    if [[ $? -ne 0 ]]; then
        return 0
    fi

    for gpu in $gpus_installed; do
        case "$gpu" in
        *NVIDIA*)
            echo "Installing NVIDIA drivers"
            install_packages nvidia-dkms nvidia-utils ocl-icd opencl-nvidia clinfo
            if [[ $(MULTILIB_ENABLED) == 1 ]]; then
                install_packages lib32-nvidia-utils lib32-opencl-nvidia
            fi

            sudo sed -i "kms //g" /etc/mkinitcpio.conf
            sudo mkinitcpio -P
            sudo sed -i '/^options/ s/$/ nvidia-drm.modeset=1/' /boot/loader/entries/*.conf
            sudo modprobe nvidia_uvm
            ;;
        *AMD*)
            echo "Installing AMD drivers"
            install_packages mesa xf86-video-amdgpu vulkan-radeon libva-mesa-driver libva-utils ocl-icd opencl-rusticl-mesa clinfo corectrl
            if [[ $(MULTILIB_ENABLED) == 1 ]]; then
                install_packages lib32-mesa lib32-vulkan-radeon lib32-libva-mesa-driver lib32-opencl-rusticl-mesa
            fi

            if [[ $(grep -q "LIBVA_DRIVER_NAME" /etc/environment) -eq 0 ]]; then
                sudo sed -i "s/LIBVA_DRIVER_NAME=.*/LIBVA_DRIVER_NAME=radeonsi/g" /etc/environment
            else
                sudo sh -c "echo 'LIBVA_DRIVER_NAME=radeonsi' >> /etc/environment"
            fi

            if [[ $(grep -q "VDPAU_DRIVER" /etc/environment) -eq 0 ]]; then
                sudo sed -i "s/VDPAU_DRIVER=.*/VDPAU_DRIVER=radeonsi/g" /etc/environment
            else
                sudo sh -c "echo 'VDPAU_DRIVER=radeonsi' >> /etc/environment"
            fi
            ;;
        *Intel*)
            echo "Installing Intel drivers"
            install_packages mesa xf86-video-intel vulkan-intel intel-media-driver libva-utils ocl-icd intel-compute-runtime clinfo
            if [[ $(MULTILIB_ENABLED) == 1 ]]; then
                install_packages lib32-mesa lib32-vulkan-intel
            fi

            if [[ $(grep -q "LIBVA_DRIVER_NAME" /etc/environment) -eq 0 ]]; then
                sudo sed -i "s/LIBVA_DRIVER_NAME=.*/LIBVA_DRIVER_NAME=iHD/g" /etc/environment
            else
                sudo sh -c "echo 'LIBVA_DRIVER_NAME=iHD' >> /etc/environment"
            fi

            if [[ $(grep -q "VDPAU_DRIVER" /etc/environment) -eq 0 ]]; then
                sudo sed -i "s/VDPAU_DRIVER=.*/VDPAU_DRIVER=iHD/g" /etc/environment
            else
                sudo sh -c "echo 'VDPAU_DRIVER=iHD' >> /etc/environment"
            fi
            ;;
        esac
    done
}
