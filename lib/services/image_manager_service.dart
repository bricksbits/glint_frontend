import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:glint_frontend/utils/image_manager/image_manager_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';

import '../utils/image_manager/image_manager_data.dart';

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
        return result;
      }
    }
    return [];
  }

  Future<List<ImageManagerData>> loadSavedImages() async {
    if (kIsWeb) return []; // No file storage on web
    final dir = await getApplicationDocumentsDirectory();
    final files = dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.contains(RegExp(r'picture_\d+\.jpg')))
        .toList();

    files.sort((a, b) => _extractNum(a.path).compareTo(_extractNum(b.path)));

    return files.map((file) => ImageManagerData(name: p.basename(file.path), file: file)).toList();
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
        .map((f) => _extractNum(f.path))
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

  int _extractNum(String path) {
    final match = RegExp(r'picture_(\d+)').firstMatch(path);
    return int.tryParse(match?.group(1) ?? '0') ?? 0;
  }
}