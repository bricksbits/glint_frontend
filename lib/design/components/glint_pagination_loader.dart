import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

/// Bottom-anchored loader rendered beneath paginated list items while the
/// next page is being fetched. Kept intentionally compact so it sits in a
/// list footer without overlaying existing rows.
class GlintPaginationLoader extends StatelessWidget {
  const GlintPaginationLoader({
    super.key,
    this.isVisible = true,
    this.size = 20.0,
    this.strokeWidth = 2.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
  });

  final bool isVisible;
  final double size;
  final double strokeWidth;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();
    return Padding(
      padding: padding,
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: const AlwaysStoppedAnimation(AppColours.primaryBlue),
          ),
        ),
      ),
    );
  }
}
