import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class UploadEventImagesContainers extends StatefulWidget {
  const UploadEventImagesContainers(
      {super.key,
      required this.selectedImagesFileList,
      required this.fetchedEventImagesList,
      required this.onImagePickUp,
      required this.onImageRemoved,
      });

  final VoidCallback onImagePickUp;
  final Function(File) onImageRemoved;
  final List<File?>? selectedImagesFileList;
  final List<String?>? fetchedEventImagesList;

  @override
  State createState() => UploadEventImagesContainersState();
}

class UploadEventImagesContainersState
    extends State<UploadEventImagesContainers> {
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
                    imageBytes: null,
                    imageFile: widget.selectedImagesFileList != null
                        ? widget.selectedImagesFileList!.length > index
                            ? widget.selectedImagesFileList![index]
                            : null
                        : null,
                    imageUrl: widget.fetchedEventImagesList != null
                        ? widget.fetchedEventImagesList!.length > index
                            ? widget.fetchedEventImagesList![index]
                            : null
                        : null,
                    onImagePick: () {
                      widget.onImagePickUp();
                    },
                    onRemoveImage: () {
                      var file =
                          widget.selectedImagesFileList!.elementAt(index);
                      if (file != null) {
                        widget.onImageRemoved(
                          file,
                        );
                      }
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
                    imageBytes: null,
                    imageUrl: widget.fetchedEventImagesList != null
                        ? widget.fetchedEventImagesList!.length > containerIndex
                            ? widget.fetchedEventImagesList![containerIndex]
                            : null
                        : null,
                    imageFile: widget.selectedImagesFileList != null
                        ? widget.selectedImagesFileList!.length > containerIndex
                            ? widget.selectedImagesFileList![containerIndex]
                            : null
                        : null,
                    onImagePick: () {
                      widget.onImagePickUp();
                    },
                    onRemoveImage: () {
                      var file = widget.selectedImagesFileList!
                          .elementAt(containerIndex);
                      if (file != null) {
                        widget.onImageRemoved(
                          file,
                        );
                      }
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
