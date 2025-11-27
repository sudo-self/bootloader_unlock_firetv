# Bootloader Unlock for Fire TV

- A simple tool to unlock the bootloader on Fire TV devices using the Android NDK.
---

## <a href="https://github.com/sudo-self/bootloader_unlock_firetv/blob/0c647a682d1e6d309e06d6c0891ff006601faac2/FireTVunlock.apk">FireTVunlock.apk</a>

## Requirements

- [Android Native Development Kit (NDK)](http://developer.android.com/tools/sdk/ndk/index.html#Downloads)

---

## Build Instructions

1. Clone the repository:

```
git clone https://github.com/sudo-self/bootloader_unlock_firetv

cd bootloader_unlock_firetv
```
2. build the binary


```
ndk-build NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk APP_ALLOW_MISSING_DEPS=true APP_PLATFORM=android-21

```
 
3. After building, the binaries will be available in the `libs/` and `obj/` directories.


## Running the Bootloader Unlock Tool on Fire TV

> ⚠️ **Warning:** Unlocking the bootloader may void your warranty or brick your device. Proceed at your own risk.

---

### 1. Prepare Your Fire TV

1. Enable **Developer Options**:
   - Go to **Settings → My Fire TV → About → Device Name**.
   - Click the device name 7 times until “You are a developer” appears.

2. Enable **ADB Debugging**:
   - Go to **Settings → My Fire TV → Developer Options → ADB Debugging → ON**.

3. Enable **Apps from Unknown Sources**:
   - Go to **Settings → My Fire TV → Developer Options → Apps from Unknown Sources → ON**.

---

### 2. Connect via ADB

1. Make sure your Fire TV and computer are on the same network.
2. Find your Fire TV’s IP address:
   - **Settings → My Fire TV → About → Network → IP Address**
3. On your computer, connect via ADB:

```sh
adb connect <FIRE_TV_IP>
adb devices
```

3. Transfer and Run the Tool

1.  Push the built binary to the Fire TV:
    

`adb push libs/arm64-v8a/unlock_firetv /data/local/tmp/` 

2.  Make it executable:
    

`adb shell chmod +x /data/local/tmp/unlock_firetv`

3. check the status

`adb shell /data/local/tmp/unlock_firetv check`
 

4.  Run the unlock tool:
    
`adb shell /data/local/tmp/unlock_firetv unlock` 

----------

## Checking if Your Fire TV is Supported for Bootloader Unlock

Not all Fire TV models allow bootloader unlocking. Here’s how to check:

---

### 1. Identify Your Device Model

1. Go to **Settings → My Fire TV → About → Device Name / Model**.
2. Note the **model number** and **software version**.

---
```
./unlock_firetv check
./unlock_firetv unlock
./unlock_firetv lock
```

### 2. Compare Against Known Supported Devices

Bootloader unlocking is typically supported on:

- **1st & 2nd generation Fire TV Stick**
- **Fire TV Stick 4K (older firmware versions)**
- Some **Fire TV Cube** models

> ⚠️ Newer devices often have a locked bootloader with no known exploits.

Check online resources such as:

- XDA Developers forums: [https://forum.xda-developers.com/](https://forum.xda-developers.com/)
- GitHub repositories for Fire TV unlock tools
--
