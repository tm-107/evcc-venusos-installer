#!/bin/sh

# Add the needed version here:

Version=0.202.0

# No need to edit after this line


if [ "$Version" = "x.xxx.x" ]; then
        echo "You have to edit the file first !!!"
        exit 1
fi

cd /data/evcc # just for safety, should not be needed
echo "stopping evcc ..."
./down
mkdir evcc-update
cd evcc-update
echo "downloading new evcc v$Version ..."
wget "https://github.com/evcc-io/evcc/releases/download/$Version/evcc_"$Version"_linux-armv6.tar.gz"
if ! test -f "/data/evcc/evcc-update/evcc_"$Version"_linux-armv6.tar.gz"; then
        echo "Download fehlgeschlagen!"
        echo "delete downloaded files ..."
        cd ..
        rm -r evcc-update
        echo "starting previous evcc-version ..."
        ./up
        exit 1
fi
echo "unpacking evcc v$Version ..."
tar xzf "evcc_"$Version"_linux-armv6.tar.gz"
echo "copying evcc v$Version ..."
cp evcc /data/evcc/
echo "delete downloaded files ..."
cd ..
rm -r evcc-update
echo "starting evcc v$Version ..."
./up
