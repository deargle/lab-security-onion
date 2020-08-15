#!/bin/bash
sudo mkdir /data && sudo chown -R securityonion /data && cd /data
wget https://tools.netsa.cert.org/silk/refdata/SiLK-LBNL-05-nonscan.tar.gz
wget https://tools.netsa.cert.org/silk/refdata/SiLK-LBNL-05-scanners.tar.gz
gzip -d -c SiLK-LBNL-05-nonscan.tar.gz | tar xf -
gzip -d -c SiLK-LBNL-05-scanners.tar.gz | tar xf -
