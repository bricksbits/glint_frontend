import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class GlintProfileImageSelector extends StatefulWidget {
  final VoidCallback onAddImage;
  final VoidCallback onDeleteImage;
  final ImageProvider? image;

  const GlintProfileImageSelector({
    super.key,
    required this.onAddImage,
    required this.onDeleteImage,
    this.image,
  });

  @override
  _GlintProfileImageSelectorState createState() =>
      _GlintProfileImageSelectorState();
}

class _GlintProfileImageSelectorState extends State<GlintProfileImageSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.image == null ? widget.onAddImage : null,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
          border: Border.all(
            color: widget.image != null ? Colors.blue : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // Image Display
            if (widget.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: widget.image!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            // Delete Button
            if (widget.image != null)
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: widget.onDeleteImage,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ),
              ),
            // Add Button
            if (widget.image == null)
              const Center(
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: AppColours.primaryBlue,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
