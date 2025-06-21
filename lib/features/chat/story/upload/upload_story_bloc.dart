import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_story_event.dart';
part 'upload_story_state.dart';
part 'upload_story_bloc.freezed.dart';

class UploadStoryBloc extends Bloc<UploadStoryEvent, UploadStoryState> {
  UploadStoryBloc() : super(const UploadStoryState.uploadStoryState()) {
    on<UploadStoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
