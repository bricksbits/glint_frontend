import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/story/story_repo.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'upload_story_event.dart';

part 'upload_story_state.dart';

part 'upload_story_bloc.freezed.dart';

//Todo: Do the Failure Media testing
class UploadStoryBloc extends Bloc<UploadStoryEvent, UploadStoryState> {
  final StoryRepo storyRepo = getIt.get<StoryRepo>();
  final ImageService imageService = getIt.get<ImageService>();

  UploadStoryBloc() : super(const UploadStoryState.uploadStoryState()) {
    on<_UploadStory>((event, emit) async {
      if (state.currentUploadedFile != null) {
        final response =
            await storyRepo.uploadStory(state.currentUploadedFile!);
        switch (response) {
          case Success<bool>():
            print("Story uploaded successfully");
          case Failure<bool>():
            add(_UpdateAndEmitNewState(state.copyWith(
                error: "Can't process the media, please try again.")));
        }
      } else {
        add(_UpdateAndEmitNewState(
            state.copyWith(error: "Please select a media first")));
      }
    });

    on<_CurrentUserStories>((event, emit) async {
      final storiesResponse = await storyRepo.getMyStories();
      switch (storiesResponse) {
        case Success<List<ViewStoryModel>>():
          final stories = storiesResponse.data;
          if (stories.isNotEmpty) {
            add(
              _UpdateAndEmitNewState(
                state.copyWith(
                  uploadedStories: stories,
                  userName: "Current User",
                  userCircularAvatarUrl:
                      "https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U",
                  isVerified: false,
                ),
              ),
            );
          }
        case Failure<List<ViewStoryModel>>():
          add(_UpdateAndEmitNewState(state.copyWith(
              error: "Cant fetch your stories please try again, later.")));
      }
    });

    on<_SelectStoryFromGallery>((event, emit) async {
      final selectedFile = await imageService.pickStory();
      if (selectedFile != null) {
        add(
          _UpdateAndEmitNewState(
            state.copyWith(
              currentUploadedFile: selectedFile.file,
              userName: "Test User",
              userCircularAvatarUrl: "https://images.unsplash.com/photo-1728577740843-5f29c7586afe?q=80&w=148&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              isVerified: false,
            ),
          ),
        );
        add(const UploadStoryEvent.uploadStory());
      } else {
        add(_UpdateAndEmitNewState(
            state.copyWith(error: "Not able tp pick images, try again")));
      }
    });

    on<_UpdateAndEmitNewState>((event, emit) {
      final newState = event.newState;
      emit(newState);
    });
  }

  void capturePassArgument(bool isUploadingStory) {
    add(_UpdateAndEmitNewState(
        state.copyWith(isUploadingStoryEvent: isUploadingStory)));
  }
}
