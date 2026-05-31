import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'confirm_ticket_state.dart';

part 'confirm_ticket_cubit.freezed.dart';

class ConfirmTicketCubit extends Cubit<ConfirmTicketState> {
  final EventRepo _eventRepo = getIt.get<EventRepo>();
  final AsyncEncryptedSharedPreferenceHelper _sharedPref =
      getIt.get<AsyncEncryptedSharedPreferenceHelper>();

  ConfirmTicketCubit() : super(const ConfirmTicketState.initial());

  Future<void> init(ConfirmTicketNavArguments args) async {
    emit(state.copyWith(
      isLoading: true,
      matchedUser: args.matchedUser,
      totalAmount: args.totalAmount,
    ));

    final userId = await _sharedPref.getString(SharedPreferenceKeys.userIdKey);
    final userName =
        await _sharedPref.getString(SharedPreferenceKeys.userNameKey);
    final userImage =
        await _sharedPref.getString(SharedPreferenceKeys.userPrimaryPicUrlKey);

    final currentUser = UserTicketHolderModel(
      userId: userId,
      username: userName.isEmpty ? "You" : userName,
      imageUrl: userImage,
    );

    final eventResult =
        await _eventRepo.getEventDetails(int.tryParse(args.eventId));

    switch (eventResult) {
      case Success<EventDetailsDomainModel>():
        final eventDetails = eventResult.data;
        final couponCode = _buildCouponCode(
          userName,
          args.matchedUser?.username ?? "",
          args.matchId,
          args.eventId,
        );
        emit(state.copyWith(
          isLoading: false,
          eventDetails: eventDetails,
          currentUser: currentUser,
          couponCode: couponCode,
        ));
      case Failure<EventDetailsDomainModel>():
        emit(state.copyWith(
          isLoading: false,
          currentUser: currentUser,
          error: "Failed to load ticket details. Please try again.",
        ));
    }
  }

  String _buildCouponCode(
    String p1Name,
    String p2Name,
    String matchId,
    String eventId,
  ) {
    final p1 = p1Name.length >= 3
        ? p1Name.substring(0, 3).toUpperCase()
        : p1Name.toUpperCase();
    final p2 = p2Name.length >= 3
        ? p2Name.substring(0, 3).toUpperCase()
        : p2Name.toUpperCase();
    return '$p1$p2$matchId$eventId';
  }
}
