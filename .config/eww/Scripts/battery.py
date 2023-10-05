#!/usr/bin/python

import time
import subprocess

bat_status_arr = ["󰁺","󰁻","󰁼","󰁽","󰁾","󰁿","󰂀","󰂁","󰂂","󰁹"]

def get_bat_status():
    acpi = subprocess.run(["acpi"], capture_output=True)

    bat_status = acpi.stdout.decode("utf-8") 
    bat_status = bat_status.split(",")[1]
         
    bat_status = bat_status.strip()
    bat_status = bat_status[:-1]
                     
    bat_status = bat_status_arr[(int(bat_status)//10)-1]

    return bat_status

print(f"{get_bat_status()}")