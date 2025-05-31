part of 'image_manager_bloc.dart';

class ImageManagerBlocState {
  final List<ImageManagerData> images;
  final bool isLoading;
  final String? error;

  ImageManagerBlocState({this.images = const [], this.isLoading = false, this.error});

  ImageManagerBlocState copyWith({
    List<ImageManagerData>? images,
    bool? isLoading,
    String? error,
  }) {
    return ImageManagerBlocState(
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}