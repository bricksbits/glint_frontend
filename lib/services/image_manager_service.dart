import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';

import '../utils/image_manager/image_manager_data.dart';

@injectable
class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<List<ImageManagerData>> pickImages({int maxCount = 9}) async {
    if (kIsWeb) {
      // Web: Pick files
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );

      if (result != null) {
        return result.files
            .take(maxCount)
            .map((file) => ImageManagerData(
                  name: file.name,
                  bytes: file.bytes,
                ))
            .toList();
      }
    } else {
      // Mobile: Pick images using image_picker
      final images = await _picker.pickMultiImage();
      if (images != null) {
        final directory = await getApplicationDocumentsDirectory();
        final existing = await _loadSavedImageNames(directory);
        final availableSlots = _getAvailableSlots(existing);

        List<ImageManagerData> result = [];

        for (int i = 0; i < images.length && i < availableSlots.length; i++) {
          final pickedFile = images[i];
          final compressedBytes = await FlutterImageCompress.compressWithFile(
            pickedFile.path,
            quality: 75,
          );

          final filename = 'picture_${availableSlots[i]}.jpg';
          final filePath = p.join(directory.path, filename);
          final file = File(filePath);
          await file.writeAsBytes(compressedBytes!);

          result.add(ImageManagerData(
            name: filename,
            file: file,
          ));
        }
        debugLogger(
          "IMAGE_SERVICE",
          "Images Picked successfully : ${result.first.file}",
        );
        return result;
      }
    }
    return [];
  }

  Future<ImageManagerData?> pickStory({int maxCount = 1}) async {
    final storyFilePath = await _picker.pickImage(source: ImageSource.gallery);
    if (storyFilePath != null) {
      final directory = await getApplicationDocumentsDirectory();
      final existing = await _loadSavedStoriesNames(directory);
      final availableSlots = _getAvailableSlots(existing);

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        storyFilePath.path,
        quality: 75,
      );

      final filename = 'story_${availableSlots.first}.jpg';
      final filePath = p.join(directory.path, filename);
      final file = File(filePath);
      await file.writeAsBytes(compressedBytes!);

      return ImageManagerData(
        name: filename,
        file: file,
      );
    }

    return null;
  }

  //Todo: Test and Verify the behaviour
  Future<List<ImageManagerData>> pickImagesForEvent({
    required String eventId,
    int maxCount = 6,
  }) async {
    // Only for mobile
    final images = await _picker.pickMultiImage();
    if (images.isEmpty) return [];

    // Define custom directory: .../eventId/files/
    final appDir = await getApplicationDocumentsDirectory();
    final eventDir = Directory(p.join(appDir.path, eventId, 'files'));

    // Ensure the directory exists
    if (!await eventDir.exists()) {
      await eventDir.create(recursive: true);
    }

    // Get existing image indices in this directory
    final existing = await _loadSavedImageNames(eventDir);
    final availableSlots = _getAvailableSlots(existing);

    List<ImageManagerData> result = [];

    for (int i = 0; i < images.length && i < availableSlots.length; i++) {
      final pickedFile = images[i];

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        pickedFile.path,
        quality: 75,
      );

      final filename = 'picture_${availableSlots[i]}.jpg';
      final filePath = p.join(eventDir.path, filename);
      final file = File(filePath);
      await file.writeAsBytes(compressedBytes!);

      result.add(ImageManagerData(
        name: filename,
        file: file,
      ));
    }

    return result;
  }

  Future<List<ImageManagerData>> loadSavedImages() async {
    if (kIsWeb) return []; // No file storage on web
    final dir = await getApplicationDocumentsDirectory();
    final files = dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.contains(RegExp(r'picture_\d+\.jpg')))
        .toList();

    files.sort((a, b) =>
        _extractPictureNum(a.path).compareTo(_extractPictureNum(b.path)));

    debugLogger(
      "IMAGE_SERVICE",
      "Load Images : ${files.length}",
    );

    return files
        .map(
            (file) => ImageManagerData(name: p.basename(file.path), file: file))
        .toList();
  }

  Future<void> deleteImage(ImageManagerData image) async {
    if (kIsWeb) return; // Web: deletion handled in memory/server
    if (image.file != null && await image.file!.exists()) {
      await image.file!.delete();
    }
  }

  Future<List<int>> _loadSavedImageNames(Directory dir) async {
    final files = dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.contains(RegExp(r'picture_\d+\.jpg')))
        .map((f) => _extractPictureNum(f.path))
        .toList();
    return files;
  }

  Future<List<int>> _loadSavedStoriesNames(Directory dir) async {
    final files = dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.contains(RegExp(r'story_\d+\.jpg')))
        .map((f) => _extractPictureNum(f.path))
        .toList();
    return files;
  }

  List<int> _getAvailableSlots(List<int> used) {
    final slots = <int>[];
    for (int i = 1; i <= 9; i++) {
      if (!used.contains(i)) slots.add(i);
    }
    return slots;
  }

  int _extractPictureNum(String path) {
    final match = RegExp(r'picture_(\d+)').firstMatch(path);
    return int.tryParse(match?.group(1) ?? '0') ?? 0;
  }

  int _extractStoryNum(String path) {
    final match = RegExp(r'story_(\d+)').firstMatch(path);
    return int.tryParse(match?.group(1) ?? '0') ?? 0;
  }
}
