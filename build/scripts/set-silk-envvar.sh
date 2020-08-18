#!/bin/bash -ex
cat <<"EOF" >> /home/securityonion/.bash_profile
export sd="--start-date=2004/10/04:20"
export sd="$sd --end-date=2005/01/08:05"
EOF
sudo chown -R securityonion: /home/securityonion
