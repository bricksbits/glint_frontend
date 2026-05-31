import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';

class TicketsBoughtListTiles extends StatefulWidget {
  const TicketsBoughtListTiles({
    super.key,
    this.limitCount,
    this.enablePagination = false,
  });

  final int? limitCount;

  /// When true, the list scrolls on its own and requests the next page
  /// from the cubit as the user approaches the bottom.
  final bool enablePagination;

  @override
  State<TicketsBoughtListTiles> createState() => _TicketsBoughtListTilesState();
}

class _TicketsBoughtListTilesState extends State<TicketsBoughtListTiles> {
  static const double _loadMoreThreshold = 200.0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.enablePagination) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final cubit = context.read<TrackAdminEventCubit>();
    if (cubit.state.isLoadingMoreTicketBought ||
        !cubit.state.hasMoreTicketBought) {
      return;
    }
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _loadMoreThreshold) {
      cubit.loadMoreTicketBoughtUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackAdminEventCubit, TrackAdminEventState>(
      buildWhen: (p, n) =>
          p.ticketBoughtUsers != n.ticketBoughtUsers ||
          p.isLoadingMoreTicketBought != n.isLoadingMoreTicketBought,
      builder: (context, state) {
        if (state.ticketBoughtUsers.isEmpty) {
          return const Center(
            child: Text(
                "None of the users have bought the ticket yet,\n wait for few moments"),
          );
        }

        final itemCount = widget.limitCount ?? state.ticketBoughtUsers.length;
        final showFooterLoader =
            widget.enablePagination && state.isLoadingMoreTicketBought;

        return ListView.builder(
          controller: widget.enablePagination ? _scrollController : null,
          shrinkWrap: !widget.enablePagination,
          physics: widget.enablePagination
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          addAutomaticKeepAlives: false,
          // +1 slot reserved for the bottom-anchored loading spinner.
          itemCount: itemCount + (showFooterLoader ? 1 : 0),
          itemBuilder: (context, index) {
            if (showFooterLoader && index == itemCount) {
              return const GlintPaginationLoader();
            }
            final person = state.ticketBoughtUsers.elementAt(index);
            final bookedAt = person.bookedAt;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildProfileRow(
                profileImageUrl1: person.userOne.thumbnailUrl,
                profileImageUrl2: person.userTwo.thumbnailUrl,
                name1: person.userOne.name,
                name2: person.userTwo.name,
                date: bookedAt?.toFormattedDate() ?? '--',
                time: bookedAt?.toFormattedTime() ?? '--',
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
            Flexible(
              child: Text(
                '$name1 & $name2',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.simpleText,
              ),
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
