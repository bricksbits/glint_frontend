import 'dart:io';

enum ImageSlotStatus { existingRemote, newLocal, empty }

class ImageSlot {
  final int slotIndex; // 1-based (1..9)
  final ImageSlotStatus status;
  final String? remoteUrl;
  final File? localFile;

  const ImageSlot._({
    required this.slotIndex,
    required this.status,
    this.remoteUrl,
    this.localFile,
  });

  factory ImageSlot.empty(int slotIndex) => ImageSlot._(
        slotIndex: slotIndex,
        status: ImageSlotStatus.empty,
      );

  factory ImageSlot.existing(int slotIndex, String url) => ImageSlot._(
        slotIndex: slotIndex,
        status: ImageSlotStatus.existingRemote,
        remoteUrl: url,
      );

  factory ImageSlot.local(int slotIndex, File file) => ImageSlot._(
        slotIndex: slotIndex,
        status: ImageSlotStatus.newLocal,
        localFile: file,
      );
}
