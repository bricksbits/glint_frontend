import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class UploadPictureContainer extends StatelessWidget {
  const UploadPictureContainer({
    super.key,
    this.isDP = false,
    this.imageFile,
    this.onImagePick,
  });

  final bool isDP;
  final File? imageFile;
  final void Function()? onImagePick;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final defaultBorder = BorderSide(
      color: isDP
          ? AppColours.primaryBlue
          : imageFile == null
              ? AppColours.darkGray
              : AppColours.primaryBlue,
      width: 0.7,
    );
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onImagePick,
          child: Container(
            height: screenSize.width > 500
                ? screenSize.width > 620
                    ? 210.0
                    : 180.0
                : 140.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColours.white,
              image: imageFile == null
                  ? null
                  : DecorationImage(
                      image: FileImage(imageFile!),
                      fit: BoxFit.cover,
                    ),
              borderRadius: BorderRadius.circular(16.0),
              border: Border(
                top: defaultBorder,
                left: defaultBorder,
                right: defaultBorder,
                bottom: defaultBorder.copyWith(width: 3.0),
              ),
            ),
            child: Center(
              child: imageFile == null
                  ? CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                          isDP ? AppColours.primaryBlue : AppColours.darkGray,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
        if (isDP)
          Positioned(
            top: -10,
            child: Container(
              height: 20.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 2.0,
              ),
              decoration: const BoxDecoration(
                color: AppColours.primaryBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
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
          )
      ],
    );
  }
}
