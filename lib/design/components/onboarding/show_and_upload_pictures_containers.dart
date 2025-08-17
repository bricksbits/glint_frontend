import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/profile/bloc/edit/profile_edit_cubit.dart';

class ShowAndUploadPicturesContainers extends StatefulWidget {
  const ShowAndUploadPicturesContainers({super.key});

  @override
  ShowAndUploadPicturesContainersState createState() =>
      ShowAndUploadPicturesContainersState();
}

class ShowAndUploadPicturesContainersState
    extends State<ShowAndUploadPicturesContainers> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
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
                          imageFile: null,
                          imageUrl: state.previewProfileModel != null
                              ? state.previewProfileModel!.pictureUrlList
                                          .length >
                                      index
                                  ? state.previewProfileModel!
                                      .pictureUrlList[index]
                                  : null
                              : null,
                          // pass the image if available
                          onImagePick: () {
                            context.read<ProfileEditCubit>().onPickImage();
                          },
                          onRemoveImage: () {
                            context
                                .read<ProfileEditCubit>()
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
                      imageFile: null,
                      imageUrl: state.previewProfileModel != null
                          ? state.previewProfileModel!.pictureUrlList.length >
                                  containerIndex
                              ? state.previewProfileModel!.pictureUrlList[index]
                              : null
                          : null,
                      // pass the image if available
                      onImagePick:
                          context.read<ProfileEditCubit>().onPickImage,
                      onRemoveImage: () {
                        context
                            .read<ProfileEditCubit>()
                            .removeImageAt(index);
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
                          imageFile: null,
                          imageUrl: state.previewProfileModel != null
                              ? state.previewProfileModel!.pictureUrlList
                                          .length >
                                      containerIndex
                                  ? state.previewProfileModel!
                                      .pictureUrlList[index]
                                  : null
                              : null,
                          // pass the image if available
                          onImagePick:
                              context.read<ProfileEditCubit>().onPickImage,
                          onRemoveImage: () {
                            context
                                .read<ProfileEditCubit>()
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
