#!/bin/zsh
# Build Android Debug APK
ENV=${1:-staging}
echo "Building APK DEBUG for: $ENV"
fvm flutter build apk --debug --dart-define=ENVIRONMENT=$ENV
