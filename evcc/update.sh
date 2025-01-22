#!/bin/sh

# For security reasons you have to make the script executable first.
# (chmod +x update.sh)

# Add the needed version here:

VERSION=x.xxx.x

# No need to edit after this line

cd /data/evcc # just for safety, should not be needed because script should be located there
./down
mkdir evcc-update
cd evcc-update
wget https://github.com/evcc-io/evcc/releases/download/$VERSION/evcc_$VERSION_linux-armv6.tar.gz
tar xzf evcc_$VERSION_linux-armv6.tar.gz
cp evcc /data/evcc/
cd ..
rm -r evcc-update
./up
