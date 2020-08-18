#!/bin/bash
echo 1:2000419 | sudo tee -a /etc/nsm/pulledpork/enablesid.conf
sudo rule-update
