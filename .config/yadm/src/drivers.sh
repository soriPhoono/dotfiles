#!/usr/bin/env bash

function install_drivers() {
  integrated=$1
  dedicated=$2

  case $integrated in
  "intel")
    echo "Installing Intel drivers"

    if ! lspci | grep -i display | grep -iq intel; then # TODO: work on this
      echo "Failed to detect Intel GPU"
      exit 1
    fi

    paru -S --noconfirm --needed \
      mesa lib32-mesa xf86-video-intel \
      vulkan-intel lib32-vulkan-intel \
      clinfo ocl-icd opencl-rusticl-mesa \
      lib32-ocl-icd lib32-opencl-rusticl-mesa \
      intel-media-driver libvdpau-va-gl

    echo "LIBVA_DRIVER_NAME=iHD" | sudo tee -a /etc/profile.d/99-hardware-acceleration.sh
    echo "VDPAU_DRIVER=va_gl" | sudo tee -a /etc/profile.d/99-hardware-acceleration.sh
    ;;
  "amd")
    echo "Installing AMD drivers"

    if ! lspci | grep -i vga | grep -iq amd; then
      echo "Failed to detect AMD GPU"
      exit 1
    fi

    paru -S --noconfirm --needed \
      mesa lib32-mesa xf86-video-amdgpu \
      vulkan-radeon lib32-vulkan-radeon \
      clinfo ocl-icd opencl-rusticl-mesa \
      lib32-ocl-icd lib32-opencl-rusticl-mesa

    echo "LIBVA_DRIVER_NAME=radeonsi" | sudo tee -a /etc/profile.d/99-hardware-acceleration.sh
    echo "VDPAU_DRIVER=radeonsi" | sudo tee -a /etc/profile.d/99-hardware-acceleration.sh
    ;;
  *)
    echo "No integrated GPU detected"
    ;;
  esac

  case $dedicated in
  "amd")
    echo "Installing AMD drivers"

    if ! lspci | grep -i vga | grep -iq amd; then
      echo "Failed to detect AMD GPU"
      exit 1
    fi

    paru -S --noconfirm --needed \
      mesa lib32-mesa xf86-video-amdgpu \
      vulkan-radeon lib32-vulkan-radeon \
      clinfo ocl-icd opencl-rusticl-mesa \
      lib32-ocl-icd lib32-opencl-rusticl-mesa \
      rocm-hip-runtime hiprt \
      rocm-opencl-runtime
    ;;
  "nvidia")
    echo "Installing NVIDIA drivers"

    if ! lspci | grep -i vga | grep -iq nvidia; then
      echo "Failed to detect NVIDIA GPU"
      exit 1
    fi

    echo "Installing core NVIDIA GPU driver"

    paru -S --noconfirm --needed \
      nvidia-open-dkms nvidia-utils \
      lib32-nvidia-utils nvidia-settings \
      nvidia-prime clinfo ocl-icd opencl-nvidia \
      lib32-ocl-icd lib32-opencl-nvidia cuda

    echo "options nvidia \"NVreg_DynamicPowerManagement=0x02\"" | sudo tee /etc/modprobe.d/nvidia-pm.conf

    cat <<EOF | sudo tee /etc/pacman.d/hooks/nvidia.hook
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
# You can remove package(s) that don't apply to your config, e.g. if you only use nvidia-open you can remove nvidia-lts as a Target
Target=nvidia
Target=nvidia-open
# If running a different kernel, modify below to match
Target=linux-zen

[Action]
Description=Updating NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case \$trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOF

    cat <<EOF | sudo tee /etc/udev/rules.d/80-nvidia-pm.rules
# Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

# Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"

# Enable runtime PM for NVIDIA VGA/3D controller devices on adding device
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"
EOF
    ;;
  *)
    echo "No dedicated GPU detected"
    ;;
  esac
}
