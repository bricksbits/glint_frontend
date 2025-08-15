import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';

class TicketsBoughtListTiles extends StatefulWidget {
  const TicketsBoughtListTiles({
    super.key,
    this.limitCount,
  });

  final int? limitCount;

  @override
  State<TicketsBoughtListTiles> createState() => _TicketsBoughtListTilesState();
}

class _TicketsBoughtListTilesState extends State<TicketsBoughtListTiles> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackAdminEventCubit, TrackAdminEventState>(
      builder: (context, state) {
        return state.ticketBoughtUsers.isEmpty
            ? const Center(
                child: Text(
                    "None of the users have bought the ticket yet,\n wait for few moments"),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.limitCount ?? state.ticketBoughtUsers.length,
                itemBuilder: (context, index) {
                  final person = state.ticketBoughtUsers.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _buildProfileRow(
                      profileImageUrl1: person.userOne.thumbnailUrl,
                      profileImageUrl2: person.userTwo.thumbnailUrl,
                      name1: person.userOne.name,
                      name2: person.userOne.name,
                      date: "Date --,--,----",
                      time: "Time --,--,--",
                    ),
                  );
                },
              );
      },
    );
  }

  Widget _buildProfileRow({
    required String profileImageUrl1,
    required String profileImageUrl2,
    required String name1,
    required String name2,
    required String date,
    required String time,
  }) {
    final profileImageUrl = [profileImageUrl1, profileImageUrl2];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColours.borderGray,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            // profile picture
            ...profileImageUrl.map(
              (userImage) => Align(
                widthFactor: 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundImage: NetworkImage(
                      userImage,
                    ),
                  ),
                ),
              ),
            ),

            const Gap(24.0),

            //profile name
            Text(
              '$name1 & $name2',
              style: AppTheme.simpleText,
            ),
            const Spacer(),
            // date and time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: AppTheme.smallBodyText.copyWith(fontSize: 10.0),
                ),
                const Gap(2.0),
                Text(
                  time,
                  style: AppTheme.smallBodyText.copyWith(fontSize: 10.0),
                ),
              ],
            ),

            // spacing in content and scrolls bar
            if (widget.limitCount == null) const Gap(24.0),
          ],
        ),
      ),
    );
  }
}
