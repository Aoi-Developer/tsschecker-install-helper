#!/bin/bash

sudo apt install make autoconf automake libtool g++ python3-dev git libusbmuxd-dev libimobiledevice-dev libplist3 gcc libplist++-dev libplist-dev libcurl4-gnutls-dev libzip-dev libreadline-dev libusb-1.0-0-dev libirecovery-1.0-dev -y
git clone https://github.com/tihmstar/libgeneral
git clone https://github.com/tihmstar/libfragmentzip
git clone https://github.com/libimobiledevice/libplist
git clone https://github.com/libimobiledevice/libimobiledevice-glue
git clone https://github.com/libimobiledevice/libirecovery
git clone  --recursive https://github.com/tihmstar/tsschecker
sudo chmod -R 777 /etc/ld.so.conf
if [ "$(cat /etc/ld.so.conf | grep "/usr/local/lib" )" ] ;then
  echo "含みます"
else
  echo "include /usr/local/lib" >> /etc/ld.so.conf
  sudo ldconfig
  echo "ライブラリを読み込むための重要な設定を行いました"
fi
cd libplist
./autogen.sh
make
sudo make install
cd ../

cd libgeneral
./autogen.sh
make
sudo make install
cd ../

cd libfragmentzip
./autogen.sh
make
sudo make install
cd ../

cd libimobiledevice-glue
./autogen.sh
make
sudo make install
cd ../

cd libirecovery
./autogen.sh
make
sudo make install
cd ../

cd tsschecker
./autogen.sh
make
sudo make install
cd ../
sudo rm -r tsschecker libirecovery libimobiledevice-glue libfragmentzip libgeneral libplist
which tsschecker >/dev/null 2>&1
if [ $? -ne 0 ] ; then
  echo "何らかの問題が発生したためインストールが失敗しました。"
else
  echo "インストールが成功しました"
fi
