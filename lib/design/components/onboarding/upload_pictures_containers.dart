import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:image_picker/image_picker.dart';

class UploadPicturesContainers extends StatefulWidget {
  const UploadPicturesContainers({super.key});

  @override
  UploadPicturesContainersState createState() =>
      UploadPicturesContainersState();
}

class UploadPicturesContainersState extends State<UploadPicturesContainers> {
  // list of images
  // final List<File?> _images = [];
  // final ImagePicker _picker = ImagePicker();
  //
  // Future<void> _pickImages() async {
  //   final List<XFile> pickedFiles = await _picker.pickMultiImage(limit: 9);
  //
  //   if (pickedFiles.isNotEmpty) {
  //     setState(() {
  //       int maxImages = 9;
  //
  //       for (var file in pickedFiles) {
  //         if (_images.length < maxImages) {
  //           _images.add(File(file.path));
  //         } else {
  //           break;
  //         }
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Column(
          children: [
            // First Row
            Transform.translate(
              offset: const Offset(0, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                  3,
                  (index) {
                    return Expanded(
                      child: Transform.translate(
                        offset:
                            Offset(index == 1 ? 0 : (index == 0 ? 4 : -4), 0),
                        child: UploadPictureContainer(
                          isDP: index == 0,
                          // first container is for DP
                          imageFile: state.uploadedFilePaths != null
                              ? state.uploadedFilePaths.length > index
                                  ? File(state.uploadedFilePaths[index])
                                  : null
                              : null,
                          // pass the image if available
                          onImagePick:
                              context.read<OnBoardingCubit>().onPickImage,
                          onRemoveImage: () {
                            context
                                .read<OnBoardingCubit>()
                                .removeImageAt(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
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
                      imageFile: state.uploadedFilePaths != null
                          ? state.uploadedFilePaths.length > containerIndex
                              ? File(state.uploadedFilePaths[containerIndex])
                              : null
                          : null,
                      // pass the image if available
                      onImagePick: context.read<OnBoardingCubit>().onPickImage,
                      onRemoveImage: () {
                        context.read<OnBoardingCubit>().removeImageAt(index);
                      },
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
                children: List.generate(
                  3,
                  (index) {
                    int containerIndex = index + 6;
                    return Expanded(
                      child: Transform.translate(
                        offset:
                            Offset(index == 1 ? 0 : (index == 0 ? 4 : -4), 0),
                        child: UploadPictureContainer(
                          imageFile: state.uploadedFilePaths != null
                              ? state.uploadedFilePaths.length > containerIndex
                                  ? File(
                                      state.uploadedFilePaths[containerIndex])
                                  : null
                              : null,
                          // pass the image if available
                          onImagePick:
                              context.read<OnBoardingCubit>().onPickImage,
                          onRemoveImage: () {
                            context
                                .read<OnBoardingCubit>()
                                .removeImageAt(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
