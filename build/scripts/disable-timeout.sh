#!/bin/bash -x
sudo -Hu securityonion  dbus-launch gsettings set org.gnome.desktop.screensaver lock-enabled false
sudo -Hu securityonion  dbus-launch gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
sudo -Hu securityonion  dbus-launch gsettings set org.compiz.integrated show-hud "['<Alt><Super>']"

