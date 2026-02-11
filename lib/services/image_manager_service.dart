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
      final directory = await getApplicationDocumentsDirectory();
      final existing = await _loadSavedImageNames(directory);
      final availableSlots = _getAvailableSlots(existing);

      final images = await _picker.pickMultiImage(limit: availableSlots.length);
      if (images.isNotEmpty) {
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

  Future<ImageManagerData?> pickStory(
    String userId,
  ) async {
    final storyFilePath = await _picker.pickImage(source: ImageSource.gallery);
    if (storyFilePath != null) {
      final directory = await _getStoryDirectory(userId);

      // Mechanism to clear the old data
      await _cleanupOldStories(directory);

      final existing = await _loadSavedStoriesNames(directory);
      final availableSlots = _getAvailableSlots(existing);

      if (availableSlots.isEmpty) {
        debugLogger(
            'ImageManagerServiceStory', 'All story slots (1-9) are filled');
        return null;
      }

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        storyFilePath.path,
        quality: 75,
      );

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'story_${availableSlots.first}_$timestamp.jpg';
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

  // Get or create user-specific story directory
  Future<Directory> _getStoryDirectory(String userId) async {
    final appDir = await getApplicationDocumentsDirectory();
    final storyDir = Directory(p.join(appDir.path, 'story_$userId'));

    if (!await storyDir.exists()) {
      await storyDir.create(recursive: true);
    }

    return storyDir;
  }

  // Extract story number from filename (FIXED REGEX)
  int _extractStoryNum(String path) {
    // Changed from picture_(\d+) to story_(\d+)
    final match = RegExp(r'story_(\d+)_\d+\.jpg').firstMatch(path);
    return int.tryParse(match?.group(1) ?? '0') ?? 0;
  }

  // Clean up stories older than 24 hours
  Future<void> _cleanupOldStories(Directory dir) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    const twentyFourHours = 24 * 60 * 60 * 1000; // milliseconds

    final files = dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.contains(RegExp(r'story_\d+_\d+\.jpg')));

    for (final file in files) {
      final timestamp = _extractTimestamp(file.path);
      if (timestamp > 0 && (now - timestamp) > twentyFourHours) {
        try {
          await file.delete();
          print('Deleted old story: ${p.basename(file.path)}');
        } catch (e) {
          print('Error deleting story: $e');
        }
      }
    }
  }

  // Extract timestamp from filename
  int _extractTimestamp(String path) {
    final match = RegExp(r'story_\d+_(\d+)\.jpg').firstMatch(path);
    return int.tryParse(match?.group(1) ?? '0') ?? 0;
  }

  Future<List<ImageManagerData>> pickImagesForEvent({
    required String eventId,
    int maxCount = 6,
  }) async {
    // Only for mobile
    final images = await _picker.pickMultiImage(limit: maxCount);
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
    if (kIsWeb) return [];
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

  // Load existing story numbers from directory
  Future<List<int>> _loadSavedStoriesNames(Directory dir) async {
    final files = dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.contains(RegExp(r'story_\d+_\d+\.jpg')))
        .map((f) => _extractStoryNum(f.path))
        .where((number) => number > 0) // Filter out any failed parses
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

  Future<void> clearAllAppData() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      if (await dir.exists()) {
        await dir.delete(recursive: true);
        debugLogger("Clear App Directory", "Cleaned");
      }
    } catch (e) {
      debugLogger("Clear App Directory", "Cleaning failed");
    }
  }
}
