#!/bin/bash
# Run a single integration test on the connected Android emulator.
# Usage: ./scripts/run_integration_test.sh <test_file>
# Example: ./scripts/run_integration_test.sh integration_test/flow4_login_chat_test.dart

set -e

DEVICE=${DEVICE:-emulator-5554}
PACKAGE="com.bricksbits.glint"
ENV=${ENV:-staging}
TEST_FILE=${1:-integration_test/flow4_login_chat_test.dart}

echo "=== Clearing app data for $PACKAGE ==="
adb -s "$DEVICE" shell pm clear "$PACKAGE" 2>/dev/null || true

echo "=== Granting runtime permissions ==="
adb -s "$DEVICE" shell pm grant "$PACKAGE" android.permission.ACCESS_FINE_LOCATION 2>/dev/null || true
adb -s "$DEVICE" shell pm grant "$PACKAGE" android.permission.ACCESS_COARSE_LOCATION 2>/dev/null || true
adb -s "$DEVICE" shell pm grant "$PACKAGE" android.permission.POST_NOTIFICATIONS 2>/dev/null || true
adb -s "$DEVICE" shell pm grant "$PACKAGE" android.permission.CAMERA 2>/dev/null || true

echo "=== Running integration test: $TEST_FILE ==="
fvm flutter test "$TEST_FILE" -d "$DEVICE" --dart-define=ENVIRONMENT="$ENV"
