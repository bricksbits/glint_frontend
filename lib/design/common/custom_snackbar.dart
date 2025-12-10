import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

/// A utility function to show a custom-styled SnackBar.
///
/// Changes color based on [isError]:
/// - true: Red background (error)
/// - false: Green background (success/normal)
void showCustomSnackbar(
  BuildContext context, {
  required String message,
  bool isError = false,
}) {
  final Color backgroundColor =
      isError ? AppColours.rejectedColor : AppColours.inApprovalColor;
  const Color iconColor = Colors.white;

  // The custom SnackBar content widget
  final SnackBar snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: backgroundColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            'lib/assets/icons/glint_logo.svg',
          ),
          const SizedBox(width: 8),
          // Message Text
          Expanded(
            child: Text(
              message,
              style: AppTheme.simpleText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    ),
    // Setting SnackBar behavior
    backgroundColor: Colors.transparent,
    // Important: make main background transparent
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 1500),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
