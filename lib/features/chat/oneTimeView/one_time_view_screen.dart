import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

class OneTimeViewScreen extends StatelessWidget {
  final String? imageUrl;
  final String? messageWithMedia;

  const OneTimeViewScreen({
    super.key,
    required this.imageUrl,
    required this.messageWithMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColours.white,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'lib/assets/icons/glint_logo.svg',
              ),
              const Gap(10),
              const Text(
                "Preview",
                style: AppTheme.simpleBodyText,
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: imageUrl != null
                  ? ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)),
                      child: InteractiveViewer(
                        minScale: 0.8,
                        maxScale: 4.0,
                        child: Image.network(
                          imageUrl!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            final loaded =
                                loadingProgress.cumulativeBytesLoaded;
                            final total =
                                loadingProgress.expectedTotalBytes;
                            return Center(
                              child: CircularProgressIndicator(
                                value: total != null
                                    ? loaded / total
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                  "Check your internet once, please."),
                            );
                          },
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                          "Invalid image — tell the sender to resend it."),
                    ),
            ),
            if (messageWithMedia != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  messageWithMedia!,
                  style: AppTheme.simpleBodyText,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
