#!/bin/bash

# Setup repositories for packages
read -p "Configure blackarch repository for cybersecurity tools? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Setup blackarch repository
	curl -O https://blackarch.org/strap.sh
	chmod +x strap.sh
	sudo ./strap.sh
	rm strap.sh
	echo "Setup blackarch repository"
fi
