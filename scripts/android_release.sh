#!/bin/zsh
# Build Android Release APK (Optimized & Obfuscated)
fvm flutter build apk --release \
  --split-per-abi \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
