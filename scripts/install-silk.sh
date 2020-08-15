#!/bin/bash
# https://web.archive.org/web/20170418230824/http://www.appliednsm.com/silk-on-security-onion/

wget http://tools.netsa.cert.org/releases/silk-3.7.2.tar.gz
wget http://tools.netsa.cert.org/releases/yaf-2.4.0.tar.gz
wget http://tools.netsa.cert.org/releases/libfixbuf-1.3.0.tar.gz

sudo apt-get install -y glib2.0 libglib2.0-dev libpcap-dev g++ python-dev

tar -xvzf libfixbuf-1.3.0.tar.gz
pushd libfixbuf-1.3.0/
./configure
make
sudo make install
popd

tar -xvzf yaf-2.4.0.tar.gz
pushd yaf-2.4.0/
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
./configure --enable-applabel
make
sudo make install
popd

tar -xvzf silk-3.7.2.tar.gz
pushd silk-3.7.2/
./configure --with-libfixbuf=/usr/local/lib/pkgconfig/ --with-python
make
sudo make install
popd


sudo tee /etc/ld.so.conf.d/silk.conf > /dev/null <<EOF
/usr/local/lib
/usr/local/lib/silk
EOF

sudo ldconfig
