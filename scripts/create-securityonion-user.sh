#!/bin/bash -e

groupadd -r autologin || true
groupadd -r nopasswdlogin || true
useradd -mG autologin,nopasswdlogin,sudo -s /bin/bash securityonion || true
echo 'securityonion:Password1' | sudo chpasswd
