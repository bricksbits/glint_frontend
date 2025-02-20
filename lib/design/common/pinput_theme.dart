import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:pinput/pinput.dart';

const defaultBorder = BorderSide(
  color: AppColours.black,
  width: 1.0,
);

const focusedBorder = BorderSide(
  color: AppColours.primaryBlue,
  width: 1.0,
);

final focusedPinTheme = PinTheme(
  height: 72.0,
  textStyle: AppTheme.simpleText.copyWith(
    fontSize: 20.0,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.0),
    border: Border(
      top: focusedBorder,
      right: focusedBorder,
      left: focusedBorder.copyWith(
        width: 3.0,
      ),
      bottom: focusedBorder.copyWith(
        width: 3.0,
      ),
    ),
  ),
);

final submittedPinTheme = PinTheme(
  height: 72.0,
  textStyle: AppTheme.simpleText.copyWith(
    fontSize: 20.0,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.0),
    border: Border(
      top: focusedBorder,
      right: focusedBorder,
      left: focusedBorder.copyWith(
        width: 3.0,
      ),
      bottom: focusedBorder.copyWith(
        width: 3.0,
      ),
    ),
  ),
);

final defaultPinTheme = PinTheme(
  height: 72.0,
  textStyle: AppTheme.simpleText.copyWith(
    fontSize: 20.0,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.0),
    border: Border(
      top: defaultBorder,
      right: defaultBorder,
      left: defaultBorder.copyWith(
        width: 3.0,
      ),
      bottom: defaultBorder.copyWith(
        width: 3.0,
      ),
    ),
  ),
);
