#!/bin/bash

# Stop dnsmasq and hostapd services
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

# Start hostapd and dnsmasq services
sudo systemctl start hostapd
sudo systemctl start dnsmasq

#sudo /usr/bin/python /home/faraaz/wifi-setup/app.py

echo "Post-reboot script execution completed."
