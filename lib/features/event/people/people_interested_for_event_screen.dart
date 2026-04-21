import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/analytics/glint_analytics_events.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/components/exports.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/design/components/profile/super_dm_dialog.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/utils/user_info/user_info_manager_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class PeopleInterestedForEventScreen extends StatefulWidget {
  const PeopleInterestedForEventScreen({
    super.key,
    required this.navArguments,
  });

  final ToEventPeopleScreenNavArguments navArguments;

  @override
  State<PeopleInterestedForEventScreen> createState() =>
      _PeopleInterestedForEventScreenState();
}

class _PeopleInterestedForEventScreenState
    extends State<PeopleInterestedForEventScreen> {
  final CardSwiperController _cardSwiperController = CardSwiperController();

  @override
  void initState() {
    super.initState();
    context.read<PeopleCardsBloc>().add(
          PeopleCardsEvent.setupSwipeController(_cardSwiperController),
        );
  }

  void _handleDm(BuildContext context, String userId, String name, String bio) {
    final cubit = context.read<UserInfoManagerCubit>();
    final isAvailable = cubit.superDmClicked();
    final streamClient = StreamChat.of(context).client;

    GlintAnalyticService.onCardActionEvent(
      GlintSwipeGestureAnalyticsEvents.DM,
      isAvailable,
    );

    if (!isAvailable) return;

    SuperDmDialog.show(
      context: context,
      name: name,
      bio: bio,
      onSend: (message) => cubit.sendSuperDm(userId, message, streamClient),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlintAppBar(
        appBarAction: GlintAppBarActions.eventProfile,
        eventName: widget.navArguments.eventName,
        eventTimeLeft: widget.navArguments.eventDaysLeft,
      ),
      body: BlocConsumer<PeopleCardsBloc, PeopleCardsState>(
        buildWhen: (prev, curr) =>
            prev.displayCards != curr.displayCards ||
            prev.currentIndex != curr.currentIndex ||
            prev.isLoading != curr.isLoading,
        listenWhen: (prev, curr) =>
            curr.error != null && prev.error != curr.error,
        listener: (context, state) {
          showCustomSnackbar(context, message: state.error!);
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final remainingCards = state.displayCards.length - state.currentIndex;

          if (remainingCards == 0) {
            return const _EventPeopleEmptyState();
          }

          return CardSwiper(
            key: const ValueKey('event_people_card_swiper'),
            cardsCount: state.displayCards.length,
            initialIndex: state.currentIndex,
            showBackCardOnUndo: true,
            numberOfCardsDisplayed: remainingCards >= 2 ? 2 : 1,
            controller: _cardSwiperController,
            isLoop: false,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            allowedSwipeDirection: const AllowedSwipeDirection.only(
              left: true,
              right: true,
              up: true,
              down: false,
            ),
            onSwipe: (prevIndex, currentIndex, direction) {
              final swipedCard = state.displayCards[prevIndex];

              switch (direction) {
                case CardSwiperDirection.left:
                  GlintAnalyticService.onCardActionEvent(
                      GlintSwipeGestureAnalyticsEvents.LEFT, false);
                  context
                      .read<PeopleCardsBloc>()
                      .add(PeopleCardsEvent.onLeftSwiped(swipedCard.userId));

                case CardSwiperDirection.right:
                  GlintAnalyticService.onCardActionEvent(
                      GlintSwipeGestureAnalyticsEvents.RIGHT, false);
                  context
                      .read<PeopleCardsBloc>()
                      .add(PeopleCardsEvent.onRightSwiped(swipedCard.userId));

                case CardSwiperDirection.top:
                  return true;

                case CardSwiperDirection.none:
                case CardSwiperDirection.bottom:
                  return false;
              }
              return true;
            },
            onUndo: (previousIndex, currentIndex, direction) {
              context
                  .read<PeopleCardsBloc>()
                  .add(const PeopleCardsEvent.undo());
              return true;
            },
            cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
              if (index >= state.displayCards.length) {
                return const _EventPeopleEmptyState();
              }

              final user = state.displayCards[index];

              return ScrollableProfileView(
                key: ObjectKey(user.userId),
                peopleUiModel: user,
                onLiked: (_) =>
                    _cardSwiperController.swipe(CardSwiperDirection.right),
                onDisLiked: (_) =>
                    _cardSwiperController.swipe(CardSwiperDirection.left),
                onSuperLiked: (_) {
                  showCustomSnackbar(context,
                      message: "Super Likes not available for Event profile");
                },
                onDm: (_) => _handleDm(
                  context,
                  user.userId,
                  user.username,
                  user.bio,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _EventPeopleEmptyState extends StatelessWidget {
  const _EventPeopleEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/assets/images/no_data_found_placeholder.jpg',
              width: 180,
              height: 180,
              fit: BoxFit.contain,
              cacheWidth: 360,
            ),
            const Gap(24),
            Text(
              'No one around yet',
              style: AppTheme.heavyBodyText,
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              'Check back soon — new people appear as they join the event.',
              style: AppTheme.simpleText.copyWith(color: AppColours.darkGray),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            GlintElevatedButton(
              label: 'Go Back',
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
