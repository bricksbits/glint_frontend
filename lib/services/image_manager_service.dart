import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../utils/image_manager/image_manager_data.dart';

@lazySingleton
class ImageService {
  final ImagePicker _picker = ImagePicker();

  /// -------------------- PICK IMAGE FOR PROFILE ------------------------ ///
  Future<List<ImageManagerData>> pickImages({int currentImageCount = 0}) async {
    // Can't select more than 9 images,
    if(currentImageCount >= 9){
      return [];
    }

    final directory = await _getProfileImagesDirectory();

    final availableSlots = await _getAvailableProfileSlots(
      currentImageCount: currentImageCount ?? 0,
    );

    // Pick images with the calculated limit
    // PickMultipleImage only works withe more than 2 limit,
    List<XFile> pickedImages = [];
    if (currentImageCount == 8) {
      final pickImage = await _picker.pickImage(source: ImageSource.gallery);
      pickImage != null ? pickedImages.add(pickImage) : null;
    } else {
      final images = await _picker.pickMultiImage(
        limit: availableSlots.length,
      );
      pickedImages.addAll(images.toList());
    }

    if (pickedImages.isNotEmpty) {
      List<ImageManagerData> result = [];

      for (int i = 0;
          i < pickedImages.length && i < availableSlots.length;
          i++) {
        final pickedFile = pickedImages[i];

        final compressedBytes = await FlutterImageCompress.compressWithFile(
          pickedFile.path,
          quality: 75,
        );

        final filename = 'picture_${availableSlots[i]}.jpg';
        final filePath = p.join(directory.path, filename);
        final file = File(filePath);
        await file.writeAsBytes(compressedBytes!);

        result.add(
          ImageManagerData(
            name: filename,
            file: file,
          ),
        );
      }
      return result;
    }

    return [];
  }

  Future<Directory> _getProfileImagesDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final profileDir = Directory(p.join(appDir.path, 'profileImages'));

    if (!await profileDir.exists()) {
      await profileDir.create(recursive: true);
    }

    return profileDir;
  }

// Get available slot numbers (e.g., [4, 5, 6, 7, 8, 9] if 1-3 are used)
  Future<List<int>> _getAvailableProfileSlots(
      {int currentImageCount = 0}) async {
    final directory = await _getProfileImagesDirectory();
    final existingLocal = await _loadSavedImageNames(directory);

    // Reserve slots for images already uploaded
    final reservedSlots = List.generate(currentImageCount, (i) => i + 1);

    // Combine reserved slots with existing local files
    final allUsedSlots = {...reservedSlots, ...existingLocal}.toList();

    // Get available slots
    return _getAvailableSlots(allUsedSlots);
  }

  Future<void> clearProfileImagesDirectory() async {
    try {
      final directory = await _getProfileImagesDirectory();

      if (await directory.exists()) {
        await directory.delete(recursive: true);
        debugLogger("IMAGE_SERVICE", "Profile images directory deleted");
      } else {
        debugLogger("IMAGE_SERVICE", "Profile images directory doesn't exist");
      }
    } catch (e) {
      debugLogger("IMAGE_SERVICE", "Error clearing profile images: $e");
      rethrow;
    }
  }

  /// --------------------------- STORY Feature --------------------------- ///
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
    final dir = await _getProfileImagesDirectory();
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
        .where((number) => number > 0) // Filter out failed parses
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
    final match = RegExp(r'picture_(\d+)\.jpg').firstMatch(path);
    return int.tryParse(match?.group(1) ?? '0') ?? 0;
  }

  Future<ImageManagerData?> pickAndCompressForSlot(int slotIndex) async {
    final directory = await _getProfileImagesDirectory();
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null;

    final compressedBytes = await FlutterImageCompress.compressWithFile(
      pickedImage.path,
      quality: 75,
    );
    if (compressedBytes == null) return null;

    final filename = 'picture_$slotIndex.jpg';
    final filePath = p.join(directory.path, filename);
    final file = File(filePath);
    await file.writeAsBytes(compressedBytes);

    return ImageManagerData(name: filename, file: file);
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

  Future<void> clearEventImagesDirectory(String eventId) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final eventDir = Directory(p.join(appDir.path, eventId));
      if (await eventDir.exists()) {
        await eventDir.delete(recursive: true);
        debugLogger("IMAGE_SERVICE", "Event images directory deleted: $eventId");
      }
    } catch (e) {
      debugLogger("IMAGE_SERVICE", "Error clearing event images ($eventId): $e");
    }
  }
}
