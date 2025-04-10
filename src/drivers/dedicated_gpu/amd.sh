#!/usr/bin/env bash

# Install ROCm amd acceleration binary

info "Installing ROCm acceleration library"

install_packages rocm-hip-runtime rocm-opencl-runtime hiprt
