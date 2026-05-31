import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/profile/bloc/edit/image_slot.dart';
import 'package:glint_frontend/features/profile/bloc/edit/profile_edit_cubit.dart';

class ShowAndUploadPicturesContainers extends StatelessWidget {
  const ShowAndUploadPicturesContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, state) {
        if (state.imageSlots.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            Transform.translate(
              offset: const Offset(0, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Transform.translate(
                      offset:
                          Offset(index == 1 ? 0 : (index == 0 ? 4 : -4), 0),
                      child: _buildSlotContainer(
                        context,
                        slot: state.imageSlots[index],
                        isDP: index == 0,
                      ),
                    ),
                  );
                }),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(3, (index) {
                final containerIndex = index + 3;
                final xOffset = -4 * index;
                return Expanded(
                  child: Transform.translate(
                    offset: Offset(xOffset.toDouble(), 0),
                    child: _buildSlotContainer(
                      context,
                      slot: state.imageSlots[containerIndex],
                    ),
                  ),
                );
              }),
            ),
            Transform.translate(
              offset: const Offset(0, -4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(3, (index) {
                  final containerIndex = index + 6;
                  return Expanded(
                    child: Transform.translate(
                      offset:
                          Offset(index == 1 ? 0 : (index == 0 ? 4 : -4), 0),
                      child: _buildSlotContainer(
                        context,
                        slot: state.imageSlots[containerIndex],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSlotContainer(
    BuildContext context, {
    required ImageSlot slot,
    bool isDP = false,
  }) {
    final isLocked = slot.status == ImageSlotStatus.existingRemote ||
        slot.status == ImageSlotStatus.newLocal;

    return UploadPictureContainer(
      isDP: isDP,
      imageFile: slot.status == ImageSlotStatus.newLocal ? slot.localFile : null,
      imageUrl:
          slot.status == ImageSlotStatus.existingRemote ? slot.remoteUrl : null,
      onImagePick: slot.status == ImageSlotStatus.empty
          ? () => context
              .read<ProfileEditCubit>()
              .selectImageForSlot(slot.slotIndex)
          : null,
      onFilledTap: isLocked
          ? () => showCustomSnackbar(
                context,
                message: "Can't replace once uploaded image",
                isError: true,
              )
          : null,
      onRemoveImage: null,
    );
  }
}
