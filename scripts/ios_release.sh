#!/bin/zsh
# Build iOS Release (with obfuscation)
fvm flutter build ios --release \
  --obfuscate \
  --split-debug-info=build/ios/outputs/symbols
