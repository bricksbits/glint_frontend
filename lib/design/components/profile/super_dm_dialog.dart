import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/components/exports.dart';

class SuperDmDialog extends StatefulWidget {
  final String initialName;
  final String initialBio;
  final Function(String userComment) onSend;

  const SuperDmDialog({
    super.key,
    required this.initialName,
    required this.initialBio,
    required this.onSend,
  });

  static void show({
    required BuildContext context,
    required String name,
    required String bio,
    required Function(String) onSend,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(
        alpha: 0.2,
      ),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),
        child: SuperDmDialog(
          initialName: name,
          initialBio: bio,
          onSend: onSend,
        ),
      ),
    );
  }

  @override
  State<SuperDmDialog> createState() => _SuperDmDialogState();
}

class _SuperDmDialogState extends State<SuperDmDialog> {
  final TextEditingController _commentController = TextEditingController();

  // Word count validator logic
  int _getWordCount(String text) =>
      text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;

  void _validateAndSubmit() {
    final text = _commentController.text;
    final wordCount = _getWordCount(text);

    if (text.isEmpty) {
      // Handle empty case
      return;
    }

    if (wordCount > 250) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Comment exceeds 250 words!")),
      );
      return;
    }

    widget.onSend(text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.all(24), // Outer padding
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Thin inner padding
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.messenger,
                color: AppColours.darkGray,
                size: 24.0,
              ),

              const SizedBox(
                height: 16,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.initialName,
                  style: AppTheme.heavyBodyText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),

              // Bio Box (Read-only as per sketch)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.initialBio,
                  style: AppTheme.simpleText.copyWith(

                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Comment Input (The Dynamic Part)
              GlintTextInputField(controller: _commentController,
              hintText: "Send a Direct message",),

              const SizedBox(height: 12),

              // Send Button
              GlintElevatedButton(
                label: 'Send',
                onPressed: () {
                  _validateAndSubmit();
                },
                customTextStyle: AppTheme.simpleBodyText.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                backgroundColor: AppColours.purpleShade.withAlpha(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
