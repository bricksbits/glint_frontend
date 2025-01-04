import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:image_picker/image_picker.dart';

class UploadPicturesContainers extends StatefulWidget {
  const UploadPicturesContainers({super.key});

  @override
  UploadPicturesContainersState createState() =>
      UploadPicturesContainersState();
}

class UploadPicturesContainersState extends State<UploadPicturesContainers> {
  // list of images
  final List<File?> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(limit: 9);

    if (pickedFiles.isNotEmpty) {
      setState(() {
        int maxImages = 9;

        for (var file in pickedFiles) {
          if (_images.length < maxImages) {
            _images.add(File(file.path));
          } else {
            break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Row
        Transform.translate(
          offset: const Offset(0, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(3, (index) {
              return Expanded(
                child: Transform.translate(
                  offset: Offset(index == 1 ? 0 : (index == 0 ? 4 : -4), 0),
                  child: UploadPictureContainer(
                    isDP: index == 0,
                    // First container is for DP
                    imageFile: _images.length > index ? _images[index] : null,
                    // Pass the image if available
                    onImagePick: _pickImages,
                  ),
                ),
              );
            }),
          ),
        ),
        // Second Row
        Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(3, (index) {
            int containerIndex = index + 3;
            final xOffset = -4 * index;
            return Expanded(
              child: Transform.translate(
                offset: Offset(xOffset.toDouble(), 0),
                child: UploadPictureContainer(
                  imageFile: _images.length > containerIndex
                      ? _images[containerIndex]
                      : null,
                  onImagePick: _pickImages,
                ),
              ),
            );
          }),
        ),
        // Third Row
        Transform.translate(
          offset: const Offset(0, -4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(3, (index) {
              int containerIndex = index + 6;
              return Expanded(
                child: Transform.translate(
                  offset: Offset(index == 1 ? 0 : (index == 0 ? 4 : -4), 0),
                  child: UploadPictureContainer(
                    imageFile: _images.length > containerIndex
                        ? _images[containerIndex]
                        : null,
                    onImagePick: _pickImages,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
