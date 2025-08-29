import 'dart:io';

import 'package:flutter/foundation.dart'; // Import for kIsWeb
import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class UploadPictureContainer extends StatelessWidget {
  const UploadPictureContainer({
    super.key,
    this.isDP = false,
    this.imageFile,
    this.imageBytes, // Uint8List for web images
    this.onImagePick,
    this.onRemoveImage,
    this.imageUrl, // New callback to remove image
  });

  final bool isDP;
  final File? imageFile;
  final Uint8List? imageBytes; // Web image data
  final VoidCallback? onImagePick;
  final VoidCallback? onRemoveImage; // Callback for removing the image
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool hasImage = imageFile != null || imageUrl != null;

    final defaultBorder = BorderSide(
      color: isDP
          ? AppColours.primaryBlue
          : (!hasImage ? AppColours.darkGray : AppColours.primaryBlue),
      width: 0.7,
    );

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onImagePick,
          child: Container(
            height: kIsWeb
                ? screenSize.width > 880
                    ? 300
                    : 140
                : screenSize.width > 500
                    ? (screenSize.width > 620 ? 210.0 : 180.0)
                    : 140.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColours.white,
              image: hasImage
                  ? DecorationImage(
                      image: imageFile != null
                          ? FileImage(imageFile!) as ImageProvider
                          : NetworkImage(imageUrl ?? ""), // Mobile image
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        //Todo: Add the Analytics here
                      })
                  : null,
              borderRadius: BorderRadius.circular(16.0),
              border: Border(
                top: defaultBorder,
                left: defaultBorder,
                right: defaultBorder,
                bottom: defaultBorder.copyWith(width: 3.0),
              ),
            ),
            child: Center(
              child: hasImage
                  ? const SizedBox.shrink()
                  : CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                          isDP ? AppColours.primaryBlue : AppColours.darkGray,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
            ),
          ),
        ),
        // icon button to remove image
        if (hasImage)
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemoveImage,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.black54.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ),
          ),
        if (isDP)
          Positioned(
            top: -10,
            child: Container(
              height: 20.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
              decoration: const BoxDecoration(
                color: AppColours.primaryBlue,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Center(
                child: Text(
                  'DP',
                  style: AppTheme.simpleText.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                    color: AppColours.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
