import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'image_manager_data.dart';

part 'image_manager_event.dart';
part 'image_manager_state.dart';

class ImageManagerBloc extends Bloc<ImageManagerEvent, ImageManagerBlocState> {
  ImageManagerBloc() : super(ImageManagerBlocState()) {
    on<ImageManagerEvent>((event, emit) {
      print("IMB started");
    });
  }
}
