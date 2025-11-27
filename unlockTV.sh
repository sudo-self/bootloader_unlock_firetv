#!/bin/bash


FIRETV_IP="10.0.0.151"


TMPDIR=$(mktemp -d)
cd "$TMPDIR" || exit 1

echo "Downloading unlock_firetv binary..."
curl -L -O https://github.com/sudo-self/bootloader_unlock_firetv/raw/main/unlock_firetv


chmod +x unlock_firetv


echo "Connecting to Fire TV at $FIRETV_IP..."
adb connect "$FIRETV_IP"


echo "Pushing binary to Fire TV..."
adb push unlock_firetv /data/local/tmp/

adb shell chmod +x /data/local/tmp/unlock_firetv


echo "Checking unlock status..."
adb shell /data/local/tmp/unlock_firetv check


read -p "Do you want to unlock the bootloader? (y/N) " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "Unlocking bootloader..."
    adb shell /data/local/tmp/unlock_firetv unlock
    echo "Done!"
else
    echo "Bootloader unlock skipped."
fi


cd -
rm -rf "$TMPDIR"
