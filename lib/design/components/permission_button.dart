import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/glint_elevated_button.dart';

enum PermissionButtonState { notRequested, inProgress, granted, denied }

class PermissionButton extends StatelessWidget {
  final PermissionButtonState buttonState;
  final String enableLabel;
  final VoidCallback? onTap;

  const PermissionButton({
    super.key,
    required this.buttonState,
    required this.enableLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: switch (buttonState) {
        PermissionButtonState.granted => _grantedButton(),
        PermissionButtonState.inProgress => _inProgressButton(),
        PermissionButtonState.denied => GlintElevatedButton(
            label: 'Make it Enable',
            onPressed: onTap,
          ),
        PermissionButtonState.notRequested => GlintElevatedButton(
            label: enableLabel,
            onPressed: onTap,
          ),
      },
    );
  }

  Widget _grantedButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.liveColor,
        foregroundColor: AppColours.white,
        disabledBackgroundColor: AppColours.liveColor,
        disabledForegroundColor: AppColours.white,
        shadowColor: Colors.transparent,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      onPressed: null,
      icon: const Icon(Icons.check_circle_outline, size: 20),
      label: const Text('Granted'),
    );
  }

  Widget _inProgressButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[400],
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey[400],
        disabledForegroundColor: Colors.white,
        shadowColor: Colors.transparent,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      onPressed: null,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
          SizedBox(width: 8),
          Text('Enabling...'),
        ],
      ),
    );
  }
}
