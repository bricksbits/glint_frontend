import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/chat/gemini_message_entity.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_with_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';

/// This will fetch the Stories along with Streak data
class FetchStoriesUseCase
    extends UseCase<List<String>, List<GeminiMessageEntity>> {
  final ChatWithRepo chatWithRepo;

  FetchStoriesUseCase(this.chatWithRepo);

  @override
  Future<Stream<List<String>?>> buildUseCaseStream(
      List<GeminiMessageEntity>? params) async {
    final StreamController<List<String>?> controller = StreamController();
    try {
      // get users
      final response = await chatWithRepo.generateAiMessage(params);
      switch (response) {
        case Success():
          final success = response as Success<List<String>>;
          controller.add(success.data);
          logger.finest('GetUsersUseCase successful.');
          controller.close();
        case Failure():
          final failure = response as Failure<Exception>;
          print(failure);
          logger.severe('GetUsersUseCase unsuccessful.');
          // Trigger .onError
          controller.addError(failure);
      }
    } catch (e) {
      print(e);
      logger.severe('GetUsersUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}
