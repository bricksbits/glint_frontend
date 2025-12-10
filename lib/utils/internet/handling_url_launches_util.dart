import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class HandlingUrlLaunchesUtil {
  static Future<void> openUrl(BuildContext context, String urlString) async {
    final Uri? url = Uri.tryParse(urlString);

    if (url == null) {
      _showError(context, "Could not open the link: Invalid URL format.");
      return;
    }

    if (await canLaunchUrl(url)) {
      try {
        await launchUrl(
          url,
          mode: LaunchMode
              .externalApplication,
        );
      } catch (e) {
        _showError(context, "Could not open the link. Please try again.");
      }
    } else {
      _showError(context,
          "Could not open the link. The requested app may not be installed.");
    }
  }

  static Future<void> openInstagramProfile(
      BuildContext context, String username) async {
    final nativeUrl = Uri.parse("instagram://user?username=$username");
    final webUrl = Uri.parse("https://www.instagram.com/$username");

    try {
      if (await canLaunchUrl(nativeUrl)) {
        await launchUrl(nativeUrl);
      }
      else if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      } else {
        _showError(context, "Could not open Instagram profile.");
      }
    } catch (e) {
      _showError(context, "An error occurred while trying to open Instagram.");
    }
  }

  static void _showError(BuildContext context, String message) {
    if (context.mounted) {
      showCustomSnackbar(context, message: message, isError: true);
    }
  }
}
