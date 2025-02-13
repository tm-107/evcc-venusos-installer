#!/bin/sh

# For security reasons you have to make the script executable first.
# (chmod +x update.sh)

# Add the needed version here:

VERSION=x.xxx.x

# No need to edit after this line

if [ "$VERSION" = "x.xxx.x" ]; then
  echo "You have to edit the file first !!!"
  exit 1
fi

cd /data/evcc # just for safety, should not be needed because script should be located there
./down
mkdir evcc-update
cd evcc-update
echo "downloading evcc ..."
wget "https://github.com/evcc-io/evcc/releases/download/$VERSION/evcc_"$VERSION"_linux-armv6.tar.gz"
echo "unpacking evcc ..."
tar xzf "evcc_"$VERSION"_linux-armv6.tar.gz"
echo "copying evcc ..."
cp evcc /data/evcc/
cd ..
echo "delete downloaded files ..."
rm -r evcc-update
./up
