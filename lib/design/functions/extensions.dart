import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

// extension for snackbar
extension SnackbarExtensions on BuildContext {
  void showSnackbar(String message,
      {Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20.0),
      ),
    );
  }
}

// extension for Bottom Sheet
extension BottomSheetExtensions on BuildContext {
  Future<T?> showBottomSheet<T>(Widget Function(BuildContext) builder,
      {bool isDismissible = true,
      bool enableDrag = true,
      Color backgroundColor = AppColours.white,
      double? elevation}) {
    return showModalBottomSheet<T>(
      context: this,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return builder(context);
      },
    );
  }
}
