import 'dart:typed_data'; // Import for Uint8List

import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:image_picker/image_picker.dart';

class UploadEventImagesContainers extends StatefulWidget {
  const UploadEventImagesContainers({super.key});

  @override
  State createState() => UploadEventImagesContainersState();
}

class UploadEventImagesContainersState
    extends State<UploadEventImagesContainers> {
  final ImagePicker _picker = ImagePicker();
  final List<Uint8List> _images = [];

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(limit: 6);

    if (pickedFiles.isNotEmpty) {
      int maxImages = 6;
      List<Uint8List> newImages = List.from(_images);

      for (var file in pickedFiles) {
        if (newImages.length < maxImages) {
          Uint8List bytes = await file.readAsBytes();
          newImages.add(bytes);
        } else {
          break;
        }
      }

      setState(() {
        _images.clear();
        _images.addAll(newImages);
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
                    imageBytes: _images.length > index ? _images[index] : null,
                    onImagePick: _pickImages,
                    onRemoveImage: () {
                      setState(() {
                        _images.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            }),
          ),
        ),
        // Second Row
        Transform.translate(
          offset: const Offset(0, -4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(3, (index) {
              int containerIndex = index + 3;
              return Expanded(
                child: Transform.translate(
                  offset: Offset(index == 1 ? 0 : (index == 0 ? 4 : -4), 0),
                  child: UploadPictureContainer(
                    imageBytes: _images.length > containerIndex
                        ? _images[containerIndex]
                        : null,
                    onImagePick: _pickImages,
                    onRemoveImage: () {
                      setState(
                        () {
                          _images.removeAt(index);
                        },
                      );
                    },
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
