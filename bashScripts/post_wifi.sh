#!/bin/bash

# Copy save_dhcpcd.conf to /etc/dhcpcd.conf
sudo cp /home/faraaz/ConfigFiles/post_dhcpcd.conf /etc/dhcpcd.conf

# Copy save_masq.conf to /etc/dnsmasq.conf
sudo cp /home/faraaz/ConfigFiles/post_dnsmasq.conf /etc/dnsmasq.conf

# Enable and start dnsmasq
#sudo systemctl stop dnsmasq
#sudo systemctl disable dnsmasq


# Restart dhcpcd and networking services
sudo systemctl restart dhcpcd
sudo systemctl restart networking

sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"


#sudo /usr/bin/python /home/faraaz/FarziTalkie/RaspiClient.py

