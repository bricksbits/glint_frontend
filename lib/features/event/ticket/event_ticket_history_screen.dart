import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_ticket_history_domain_model.dart';
import 'package:glint_frontend/features/event/ticket/bloc/ticket_history_cubit.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class EventTicketHistoryScreen extends StatefulWidget {
  const EventTicketHistoryScreen({super.key});

  @override
  State<EventTicketHistoryScreen> createState() =>
      _EventTicketHistoryScreenState();
}

class _EventTicketHistoryScreenState extends State<EventTicketHistoryScreen> {
  static const double _loadMoreThreshold = 200.0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final cubit = context.read<TicketHistoryCubit>();
    // Short-circuit before dispatching on every scroll frame.
    if (cubit.state.isLoadingMore || !cubit.state.hasMore) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _loadMoreThreshold) {
      cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColours.white,
        centerTitle: false,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColours.lightGray,
            height: 1.0,
          ),
        ),
        title: const Text(
          'Your Tickets',
          style: AppTheme.headingThree,
        ),
      ),
      body: BlocBuilder<TicketHistoryCubit, TicketHistoryState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.tickets.isEmpty) {
            return Center(
              child: Text(
                state.error ?? 'No tickets yet.',
                style: AppTheme.simpleText,
                textAlign: TextAlign.center,
              ),
            );
          }

          final itemCount =
              state.tickets.length + (state.isLoadingMore ? 1 : 0);

          return ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            itemCount: itemCount,
            separatorBuilder: (_, __) => const Gap(16.0),
            itemBuilder: (context, index) {
              // Footer slot is bottom-anchored beneath existing rows.
              if (state.isLoadingMore && index == state.tickets.length) {
                return const GlintPaginationLoader();
              }
              return _TicketHistoryCard(ticket: state.tickets[index]);
            },
          );
        },
      ),
    );
  }
}

class _TicketHistoryCard extends StatelessWidget {
  const _TicketHistoryCard({required this.ticket});

  final EventTicketHistoryDomainModel ticket;

  @override
  Widget build(BuildContext context) {
    const cardHeight = 148.0;
    final screenSize = MediaQuery.of(context).size;
    final eventHasPassed = ticket.daysLeft.isEmpty;
    final interactedUsers = [
      ticket.currentUser.imageUrl,
      ticket.matchedUser.imageUrl,
    ].where((url) => url.isNotEmpty).toList();

    return GestureDetector(
      onTap: () => context.pushNamed(
        GlintMainRoutes.confirmTicket.name,
        extra: ConfirmTicketNavArguments(
          eventId: ticket.eventId,
          matchId: ticket.matchId,
          matchedUser: ticket.matchedUser,
          totalAmount: ticket.eventCurrentPrice,
        ),
      ),
      child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: AppColours.backgroundShade,
              width: 0.8,
            ),
            color: AppColours.white,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // event name
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        ticket.eventName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.headingFour.copyWith(
                          fontStyle: FontStyle.normal,
                          color: AppColours.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    if (!eventHasPassed) ...[
                      const Gap(12.0),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColours.black,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 3.0,
                        ),
                        child: Text(
                          '${ticket.daysLeft} days left',
                          style: const TextStyle(
                            fontFamily: 'AlbertSans',
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            color: AppColours.white,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),

                // event Location and Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlintIconLabel(
                      iconPath: 'lib/assets/icons/calendar_icon.svg',
                      svgColor: AppColours.primaryBlue,
                      label: ticket.eventdate,
                      style: AppTheme.simpleText.copyWith(
                        fontSize: 12.0,
                        color: AppColours.black,
                      ),
                    ),
                    const Gap(8.0),
                    GlintIconLabel(
                      iconPath: 'lib/assets/icons/location_icon.svg',
                      svgColor: AppColours.primaryBlue,
                      label: ticket.eventLocation,
                      style: AppTheme.simpleText.copyWith(
                        fontSize: 12.0,
                        color: AppColours.black,
                      ),
                    ),
                  ],
                ),

                // matched user row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...interactedUsers.map(
                      (userImage) => Align(
                        widthFactor: 0.6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: CircleAvatar(
                            radius: 8.0,
                            backgroundImage: NetworkImage(userImage),
                          ),
                        ),
                      ),
                    ),
                    const Gap(12.0),
                    Flexible(
                      child: Text(
                        'You & ${ticket.matchedUser.username}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.smallBodyText.copyWith(
                          color: AppColours.black,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: screenSize.width > 620
                ? 300.0
                : screenSize.width < 430
                    ? 80.0
                    : 150.0,
            height: cardHeight,
            decoration: BoxDecoration(
              image: ticket.eventCoverImageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(ticket.eventCoverImageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: ticket.eventCoverImageUrl.isEmpty
                  ? AppColours.backgroundShade
                  : null,
              border: const Border(
                left: BorderSide(
                  color: AppColours.white,
                  width: 1.5,
                ),
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }
}
