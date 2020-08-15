#!/bin/bash
# https://docs.securityonion.net/en/16.04/network-configuration.html

sudo /etc/init.d/network-manager stop
sudo mv /etc/init/network-manager.conf /etc/init/network-manager.conf.DISABLED || true
sudo systemctl stop NetworkManager.service
sudo systemctl disable NetworkManager.service
sudo stop network-manager || true
echo "manual" | sudo tee /etc/init/network-manager.override


sudo tee /etc/network/interfaces > /dev/null <<'EOF'
# This configuration was created by the Security Onion setup script.
#
# The original network interface configuration file was backed up to:
# /etc/network/interfaces.bak.
#   
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# loopback network interface
auto lo
iface lo inet loopback

# Management network interface
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet manual
  up ip link set $IFACE promisc on arp off up
  down ip link set $IFACE promisc off down
  post-up for i in rx tx sg tso ufo gso gro lro; do ethtool -K $IFACE $i off; done
  post-up echo 1 > /proc/sys/net/ipv6/conf/$IFACE/disable_ipv6
  # You probably don't need to enable or edit the following setting,
  # but it is included for completeness.
  # Note that increasing beyond the default may result in inconsistent traffic:
  # https://taosecurity.blogspot.com/2019/04/troubleshooting-nsm-virtualization.html
  # post-up ethtool -G $IFACE rx 256
EOF

sudo /etc/init.d/networking restart
#sudo so-sensor-restart

