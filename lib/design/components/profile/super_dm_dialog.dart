import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      barrierColor: Colors.black.withValues(alpha: 0.2),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
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

  int _getWordCount(String text) =>
      text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;

  void _validateAndSubmit() {
    final text = _commentController.text;
    final wordCount = _getWordCount(text);

    if (text.isEmpty) return;

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
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Dialog(
      backgroundColor: AppColours.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────── //
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColours.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: AppColours.white,
                      size: 18,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Super DM', style: AppTheme.heavyBodyText),
                        Text(
                          widget.initialName,
                          style: AppTheme.simpleText.copyWith(
                            color: AppColours.darkGray,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: AppColours.darkGray,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              const Divider(color: AppColours.borderGray, height: 1),
              const Gap(16),

              // ── Bio ──────────────────────────────────────────────────────── //
              Text(
                'About',
                style: AppTheme.simpleText.copyWith(
                  color: AppColours.darkGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColours.backgroundShade,
                  border: Border.all(color: AppColours.borderGray),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.initialBio.isEmpty
                      ? 'No bio added yet.'
                      : widget.initialBio,
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.darkGray,
                  ),
                ),
              ),
              const Gap(16),

              // ── Message input ────────────────────────────────────────────── //
              Text(
                'Message',
                style: AppTheme.simpleText.copyWith(
                  color: AppColours.darkGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(8),
              Container(
                decoration: BoxDecoration(
                  color: AppColours.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColours.primaryBlue,
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  controller: _commentController,
                  maxLines: 4,
                  minLines: 3,
                  cursorColor: AppColours.primaryBlue,
                  style: AppTheme.simpleBodyText.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColours.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    hintText: 'Write your message…',
                    hintStyle: AppTheme.simpleBodyText.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColours.gray60,
                    ),
                  ),
                ),
              ),
              const Gap(20),

              // ── Actions ──────────────────────────────────────────────────── //
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColours.darkGray,
                        side: const BorderSide(color: AppColours.borderGray),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: AppTheme.simpleBodyText.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColours.darkGray,
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: GlintElevatedButton(
                      label: 'Send',
                      onPressed: _validateAndSubmit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
