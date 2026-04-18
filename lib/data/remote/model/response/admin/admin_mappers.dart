import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_stats_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';

import 'get_event_stats_for_admin.dart';
import 'get_interested_users_response.dart';
import 'get_ticket_booked_response.dart';

extension GetTicketBoughtUsersResponseMappper on GetTicketBookedResponse {
  List<EventTicketBoughtDomainModel> mapToDomain() {
    var items = response
        ?.map(
          (user) => EventTicketBoughtDomainModel(
            userOne: EventInterestedUserDomainModel(
              id: user.user1Id.toString(),
              name: user.user1Username ?? "",
              emailId: user.user1EmailId ?? "",
              thumbnailUrl: user.user1ProfilePictureUrl?.presignedUrl ?? "",
            ),
            userTwo: EventInterestedUserDomainModel(
              id: user.user2Id.toString(),
              name: user.user2Username ?? "",
              emailId: user.user2EmailId ?? "",
              thumbnailUrl: user.user2ProfilePictureUrl?.presignedUrl ?? "",
            ),
            bookedAt: _parseBookedAt(user.bookedAtTime),
          ),
        )
        .toList();

    return items ?? [];
  }
}

DateTime? _parseBookedAt(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  return DateTime.tryParse(raw)?.toLocal();
}

extension GetInterestedUsersMapper on GetInterestedUsersResponse {
  List<EventInterestedUserDomainModel> mapToDomain() {
    var items = response?.map((users) {
          return EventInterestedUserDomainModel(
              id: users.userId.toString(),
              name: users.username ?? "",
              emailId: users.emailId ?? "",
              thumbnailUrl: users.profilePicture?.presignedUrl ?? "");
        }).toList() ??
        [];
    return items;
  }
}

extension GetEventStatsMapper on GetEventStatsForAdmin {
  EventStatsDomainModel mapToDomain() {
    final stats = response;
    final interestedUsers = stats?.interestedUserInfo
            ?.map((u) => EventInterestedUserDomainModel(
                  id: u.userId.toString(),
                  name: u.username ?? "",
                  emailId: u.emailId ?? "",
                  thumbnailUrl: u.profilePicture?.presignedUrl ?? "",
                ))
            .toList() ??
        [];
    final ticketsBought = stats?.ticketsBooked
            ?.map((t) => EventTicketBoughtDomainModel(
                  userOne: EventInterestedUserDomainModel(
                    id: t.user1Id.toString(),
                    name: t.user1Username ?? "",
                    emailId: t.user1EmailId ?? "",
                    thumbnailUrl: t.user1ProfilePictureUrl?.presignedUrl ?? "",
                  ),
                  userTwo: EventInterestedUserDomainModel(
                    id: t.user2Id.toString(),
                    name: t.user2Username ?? "",
                    emailId: t.user2EmailId ?? "",
                    thumbnailUrl: t.user2ProfilePictureUrl?.presignedUrl ?? "",
                  ),
                  bookedAt: _parseBookedAt(t.bookedAtTime),
                ))
            .toList() ??
        [];
    return EventStatsDomainModel(
      (stats?.revenueGenerated ?? 0).toString(),
      (stats?.ticketsBooked?.length ?? 0).toString(),
      interestedUsers,
      ticketsBought,
    );
  }
}
