import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'image_manager_data.dart';

part 'image_manager_event.dart';
part 'image_manager_state.dart';

class ImageManagerBloc extends Bloc<ImageManagerEvent, ImageManagerBlocState> {
  ImageManagerBloc() : super(ImageManagerBlocState()) {
    on<ImageManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
