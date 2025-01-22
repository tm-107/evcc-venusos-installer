#!/bin/sh

# Add the needed version here:

VERSION=0.133.0

# No need to edit after this line

cd /data/evcc # just for safety, should not be needed
./down
mkdir evcc-update
cd evcc-update
wget https://github.com/evcc-io/evcc/releases/download/$VERSION/evcc_$VERSION_linux-armv6.tar.gz
tar xzf evcc_$VERSION_linux-armv6.tar.gz
cp evcc /data/evcc/
cd ..
rm -r evcc-update
./up
