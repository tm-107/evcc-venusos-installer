#!/bin/sh

# Add the needed version here:

Version=x.xxx.x

# No need to edit after this line


if [ "$Version" = "x.xxx.x" ]; then
        echo "You have to edit the file first !!!"
        exit 1
fi

cd /data/evcc # just for safety, should not be needed
if ! [ "$?" = 0 ]; then
        echo "Fehler: EVCC-Verzeichnis nicht vorhanden?"
        exit 1
fi

echo "stopping evcc ..."
./down
mkdir evcc-update
if ! [ "$?" = 0 ]; then
        echo "Fehler beim Erstellen des temporaeren Verzeichnis"
        exit 1
fi
cd evcc-update
if ! [ "$?" = 0 ]; then
        echo "Temporaeres Verzeichnis nicht gefunden"
        exit 1
fi
echo "downloading new evcc v$Version ..."
wget "https://github.com/evcc-io/evcc/releases/download/$Version/evcc_"$Version"_linux-armv6.tar.gz"
if ! [ "$?" = 0 ]; then
        echo "Error downloading new version"
        echo "delete temporary files ..."
        cd ..
        rm -r evcc-update
        echo "starting previous evcc-version ..."
        ./up
        exit 1
fi

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
if ! [ "$?" = 0 ]; then
        echo "Error unpacking new version"
        echo "delete temporary files ..."
        cd ..
        rm -r evcc-update
        echo "starting previous evcc-version ..."
        ./up
        exit 1
fi

echo "backup database ..."
cp /data/evcc/evcc.db /data/evcc/evcc.db_backup

echo "copying evcc v$Version ..."
cp evcc /data/evcc/
if ! [ "$?" = 0 ]; then
        echo "Error copying new version"
        echo "delete temporary files ..."
        cd ..
        rm -r evcc-update
        echo "starting previous evcc-version ..."
        ./up
        exit 1
fi

echo "delete downloaded files ..."
cd ..
rm -r evcc-update
echo "starting evcc v$Version ..."
./up
