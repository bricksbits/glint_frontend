#!/bin/zsh
# Build Android App Bundle (Play Store)
ENV=${1:-prod}
echo "Building AAB for: $ENV"
fvm flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols \
  --dart-define=ENVIRONMENT=$ENV
