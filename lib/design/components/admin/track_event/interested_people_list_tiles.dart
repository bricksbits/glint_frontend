import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';

class InterestedPeopleListTiles extends StatefulWidget {
  const InterestedPeopleListTiles({
    super.key,
    this.limitCount,
  });

  final int? limitCount;

  @override
  State<InterestedPeopleListTiles> createState() =>
      _InterestedPeopleListTilesState();
}

class _InterestedPeopleListTilesState extends State<InterestedPeopleListTiles> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackAdminEventCubit, TrackAdminEventState>(
      builder: (context, state) {
        return state.interestedUsers.isEmpty
            ? const Center(
                child: Text(
                  "None of the users have show interest yet,\n wait for few moments",
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    widget.limitCount ?? int.parse(state.interestedUserCount),
                itemBuilder: (context, index) {
                  final person = state.interestedUsers.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _buildProfileRow(
                      profileImageUrl: person.thumbnailUrl,
                      name: person.name,
                      email: person.emailId,
                    ),
                  );
                },
              );
      },
    );
  }

  Widget _buildProfileRow({
    required String profileImageUrl,
    required String name,
    required String email,
  }) {
    return Row(
      children: [
        // profile picture
        CircleAvatar(
          radius: 14.0,
          backgroundImage: NetworkImage(profileImageUrl),
        ),

        const Gap(12.0),

        //profile name
        Text(
          name,
          style: AppTheme.simpleText,
        ),
        const Gap(12.0),
        const Text(
          ' | ',
          style: AppTheme.simpleText,
        ),
        const Gap(8.0),
        //email
        Text(
          email,
          style: AppTheme.simpleText.copyWith(
            color: AppColours.gray,
          ),
        ),
      ],
    );
  }
}
