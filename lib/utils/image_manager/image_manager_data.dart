import 'dart:io';
import 'dart:typed_data';

class ImageManagerData {
  final String name;
  final Uint8List? bytes;
  final File? file;

  ImageManagerData({required this.name, this.bytes, this.file});
}