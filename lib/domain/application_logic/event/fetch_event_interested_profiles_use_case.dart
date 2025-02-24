// import 'dart:async';
//
// import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
// import 'package:glint_frontend/data/remote/utils/api_response.dart';
// import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
// import 'package:glint_frontend/utils/clean_arch_use_case.dart';
//
// class FetchEventInterestedProfilesUseCase extends UseCase<List<Profile>, int> {
//   final EventRepo eventRepo;
//
//   FetchEventInterestedProfilesUseCase(this.eventRepo);
//
//   @override
//   Future<Stream<List<Profile>?>> buildUseCaseStream(int? params) async {
//     final StreamController<List<Profile>?> controller = StreamController();
//     try {
//       final eventDetailsResponse =
//           await eventRepo.fetchInterestedProfiles(params);
//       switch (eventDetailsResponse) {
//         case Success():
//           controller.add(eventDetailsResponse.data);
//           logger.finest('fetching event details successful.');
//         case Failure():
//           controller.addError(eventDetailsResponse.error);
//           logger.severe('fetching event details unsuccessful.');
//           print(eventDetailsResponse.error);
//       }
//       controller.close();
//     } catch (caughtError) {
//       controller.addError(caughtError);
//     }
//
//     return controller.stream;
//   }
// }
