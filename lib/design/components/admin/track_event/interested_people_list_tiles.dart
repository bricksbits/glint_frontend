import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';

class InterestedPeopleListTiles extends StatefulWidget {
  const InterestedPeopleListTiles({
    super.key,
    this.limitCount,
    this.enablePagination = false,
  });

  final int? limitCount;

  /// When true, the list scrolls on its own and requests the next page
  /// from the cubit as the user approaches the bottom.
  final bool enablePagination;

  @override
  State<InterestedPeopleListTiles> createState() =>
      _InterestedPeopleListTilesState();
}

class _InterestedPeopleListTilesState extends State<InterestedPeopleListTiles> {
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
    // Short-circuit before the cubit call so we don't dispatch on every
    // scroll frame while a fetch is in flight or the list is exhausted.
    if (cubit.state.isLoadingMoreInterested ||
        !cubit.state.hasMoreInterested) {
      return;
    }
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _loadMoreThreshold) {
      cubit.loadMoreInterestedUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackAdminEventCubit, TrackAdminEventState>(
      buildWhen: (p, n) =>
          p.interestedUsers != n.interestedUsers ||
          p.isLoadingMoreInterested != n.isLoadingMoreInterested,
      builder: (context, state) {
        if (state.interestedUsers.isEmpty) {
          return const Center(
            child: Text(
              "None of the users have show interest yet,\n wait for few moments",
            ),
          );
        }

        final itemCount = widget.limitCount ?? state.interestedUsers.length;
        final showFooterLoader =
            widget.enablePagination && state.isLoadingMoreInterested;

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
        Flexible(
          flex: 2,
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.simpleText,
          ),
        ),
        const Gap(4.0),
        const Text(
          ' | ',
          style: AppTheme.simpleText,
        ),
        const Gap(4.0),
        //email
        Flexible(
          flex: 3,
          child: Text(
            email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.simpleText.copyWith(
              color: AppColours.gray,
            ),
          ),
        ),
      ],
    );
  }
}
