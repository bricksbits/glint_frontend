part of 'confirm_ticket_cubit.dart';

@freezed
class ConfirmTicketState with _$ConfirmTicketState {
  const factory ConfirmTicketState.initial({
    @Default(true) bool isLoading,
    @Default(null) EventDetailsDomainModel? eventDetails,
    @Default(null) UserTicketHolderModel? currentUser,
    @Default(null) UserTicketHolderModel? matchedUser,
    @Default(null) String? totalAmount,
    @Default(null) String? couponCode,
    @Default(null) String? error,
  }) = _Initial;
}
