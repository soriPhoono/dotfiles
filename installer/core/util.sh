function check_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "This script must not be run as root"
        exit 1
    fi
}

function update() {
    sh -c "$PACKAGE_MANAGER -Syu"
}

function print_header() {
    echo "========================================"
    echo "Installing $1"
    echo "========================================"
}

function print_footer() {
    echo "========================================"
    echo "Finished installing $1"
    echo "========================================"
}

function confirm() {
    if [[ $2 == "y" ]]; then
        prompt="$1 [Y/n]"
    elif [[ $2 == "n" ]]; then
        prompt="$1 [y/N]"
    else
        prompt="$1 [y/n]"
    fi

    read -p "$prompt " -n 1 -r
}

function backup() {
    if [[ $2 -eq 1 ]]; then
        if [[ $1 == "~/*" || $1 == "$HOME/*" ]]; then
            mv -r $1 $1.bak
        else
            sudo mv -r $1 $1.bak
        fi
    else
        if [[ $1 == "~/*" || $1 == "$HOME/*" ]]; then
            cp -r $1 $1.bak
        else
            sudo cp -r $1 $1.bak
        fi
    fi
}

function copy_config() {
    if [[ $1 == "~/*" || $1 == "$HOME/*" ]]; then
        cp -r "$(dirname $ROOT_DIR)/${1:2}" $1
    else
        sudo cp -r "$ROOT_DIR/root$1" $1
    fi
}

function install_packages() {
    packages="${@}"

    sh -c "$PACKAGE_MANAGER -S $packages"
}
