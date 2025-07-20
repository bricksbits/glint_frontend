import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/services/image_manager_service.dart';

import '../../di/injection.dart';

part 'service_screen_state.dart';

part 'service_screen_cubit.freezed.dart';

class ServiceScreenCubit extends Cubit<ServiceScreenState> {
  final ImageService imageService = getIt.get<ImageService>();

  ServiceScreenCubit() : super(const ServiceScreenState.initial()) {
    _loadImagesFromDir();
  }

  Future<void> _loadImagesFromDir() async {
    var images = await imageService.loadSavedImages();
    images.forEach((item) {
      print("Service: ${item}");
    });
  }

  void picImages() {
    imageService.pickImages();
    _loadImagesFromDir();
  }
}
