#!/bin/bash


FIRETV_IP="10.0.0.151"        # Change this to your Fire TV IP
TMPDIR=$(mktemp -d)
GITHUB_BASE="https://raw.githubusercontent.com/sudo-self/bootloader_unlock_firetv/deae47c8170392a6c87ed13b1f3cc970374376c0"


cd "$TMPDIR" || exit 1
echo "Downloading unlockTV.sh and unlock_firetv binary..."
curl -L -o unlockTV.sh "$GITHUB_BASE/unlockTV.sh"
curl -L -o unlock_firetv "$GITHUB_BASE/unlock_firetv"


chmod +x unlockTV.sh unlock_firetv


echo "Connecting to Fire TV at $FIRETV_IP..."
adb connect "$FIRETV_IP"


echo "Pushing unlock_firetv binary to Fire TV..."
adb push unlock_firetv /data/local/tmp/
adb shell chmod +x /data/local/tmp/unlock_firetv

echo "Pushing unlockTV.sh script to Fire TV..."
adb push unlockTV.sh /data/local/tmp/
adb shell chmod +x /data/local/tmp/unlockTV.sh


echo "Running bootloader check..."
adb shell /data/local/tmp/unlock_firetv check

# === CONFIRM UNLOCK ===
read -p "Do you want to unlock the bootloader? (y/N) " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "Unlocking bootloader..."
    adb shell /data/local/tmp/unlock_firetv unlock
    echo "Bootloader unlock command sent!"
else
    echo "Bootloader unlock skipped."
fi

cd -
rm -rf "$TMPDIR"
echo "Done!"

