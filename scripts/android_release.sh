#!/bin/zsh
# Build Android Release APK (Optimized & Obfuscated)
ENV=${1:-prod}
echo "Building APK for: $ENV"
fvm flutter build apk --release \
  --split-per-abi \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols \
  --dart-define=ENVIRONMENT=$ENV