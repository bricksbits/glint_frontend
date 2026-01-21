# Flutter Project - Developer Build Guide

All builds are now provided as **runnable shell scripts** (`.sh`) inside the `scripts/` folder.  
Open any script in Android Studio / IntelliJ, and you will see the ▶️ run button in the gutter.  
Alternatively, run them from terminal with `./scripts/<script>.sh`.

---

## 🔹 Android Builds
- Debug APK → [`scripts/android_debug.sh`](scripts/android_debug.sh)
- Release APK (Optimized & Obfuscated) → [`scripts/android_release.sh`](scripts/android_release.sh)
- Release App Bundle (Play Store) → [`scripts/android_bundle.sh`](scripts/android_bundle.sh)

---

## 🔹 iOS Builds
- Debug → [`scripts/ios_debug.sh`](scripts/ios_debug.sh)
- Release (Optimized & Obfuscated) → [`scripts/ios_release.sh`](scripts/ios_release.sh)

---

## 🔧 Utility
- Clean Build Artifacts → [`scripts/clean.sh`](scripts/clean.sh)
- Get Dependencies → [`scripts/pub_get.sh`](scripts/pub_get.sh)
- Run App on Device → [`scripts/run.sh`](scripts/run.sh)

---

## ⚡ Setup
1. Make all scripts executable:
   ```zsh
   chmod +x scripts/*.sh


## Android Builds commands 
For Prod: ./scripts/android_bundle.sh prod
For Staging: ./scripts/android_bundle.sh staging