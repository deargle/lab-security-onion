#!/bin/bash -x
sudo mkdir /data && sudo chown -R securityonion /data
cd /data

#silk
if [ ! -d /data/SiLK-LBNL-05 ]; then
  wget https://tools.netsa.cert.org/silk/refdata/SiLK-LBNL-05-nonscan.tar.gz
  wget https://tools.netsa.cert.org/silk/refdata/SiLK-LBNL-05-scanners.tar.gz
  gzip -d -c SiLK-LBNL-05-nonscan.tar.gz | tar xf -
  gzip -d -c SiLK-LBNL-05-scanners.tar.gz | tar xf -
fi

#cases
wget https://github.com/deargle/lab-security-onion/raw/master/case.pcap
wget https://github.com/deargle/lab-security-onion/raw/master/evidence.pcap
