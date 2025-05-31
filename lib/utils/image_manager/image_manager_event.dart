part of 'image_manager_bloc.dart';

@immutable
sealed class ImageManagerEvent {}

class LoadImages extends ImageManagerEvent {}
class PickImages extends ImageManagerEvent {}
class DeleteImage extends ImageManagerEvent {
  final ImageManagerData image;
  DeleteImage(this.image);
}