#!/bin/zsh
# Build Android App Bundle (Play Store)
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
