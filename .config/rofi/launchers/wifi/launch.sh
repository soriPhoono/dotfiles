#!/usr/bin/env bash

source $HOME/.local/bin/environment.sh

notify-send -r 996 -i "$icon_wifi" "Getting Wi-Fi networks..."

wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")
notify-send -r 996 -i "$icon_succes" "Done"

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="󰖪  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="󰖩  Enable Wi-Fi"
fi

chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -theme "$rofi_theme_wifi")
chosen_id=$(echo "${chosen_network:3}" | xargs)

if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "󰖩 Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
	nmcli radio wifi off
else
	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "successfully" && notify-send -i "$icon_succes" "Connected"
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(rofi -dmenu -password -theme "$rofi_theme_wifi" )
		fi
		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send -i "$icon_succes" "Connected"
	fi
fi

