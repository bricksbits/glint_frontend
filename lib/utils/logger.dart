import 'dart:developer';

import 'package:flutter/foundation.dart';

void debugLogger(
  String logPrefix,
  String value,
) {
  if (kDebugMode) {
    log(value, name: logPrefix);
  }
}
