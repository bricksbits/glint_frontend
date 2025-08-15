import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';

import 'get_interested_users_response.dart';
import 'get_ticket_booked_response.dart';

extension GetTicketBoughtUsersResponseMappper on GetTicketBookedResponse {
  List<EventTicketBoughtDomainModel> mapToDomain() {
    var items = response
        ?.map(
          (user) => EventTicketBoughtDomainModel(
            EventInterestedUserDomainModel(
              id: user.user1Id.toString(),
              name: user.user1Username ?? "",
              emailId: user.user1EmailId ?? "",
              thumbnailUrl: user.user1ProfilePictureUrl?.presignedUrl ?? "",
            ),
            EventInterestedUserDomainModel(
                id: user.user2Id.toString(),
                name: user.user2Username ?? "",
                emailId: user.user2EmailId ?? "",
                thumbnailUrl: user.user2ProfilePictureUrl?.presignedUrl ?? ""),
          ),
        )
        .toList();

    return items ?? [];
  }
}

extension GetInterestedUsersMapper on GetInterestedUsersResponse {
  List<EventInterestedUserDomainModel> mapToDomain() {
    var items = response?.map((users) {
          return EventInterestedUserDomainModel(
              id: users.userId.toString() ?? "",
              name: users.username ?? "",
              emailId: users.username ?? "",
              thumbnailUrl: users.username ?? "");
        }).toList() ??
        [];
    return items;
  }
}
