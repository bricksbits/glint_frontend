#!/bin/zsh
# Build iOS Release (with obfuscation)
flutter build ios --release \
  --obfuscate \
  --split-debug-info=build/ios/outputs/symbols
