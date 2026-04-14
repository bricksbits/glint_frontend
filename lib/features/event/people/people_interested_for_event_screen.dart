import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/analytics/glint_analytics_events.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/components/exports.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:go_router/go_router.dart';

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
            return _EventPeopleEmptyState();
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
                  // Super like is triggered directly via superLikeUser();
                  // the swipe direction.top callback fires after the animation.
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
                return _EventPeopleEmptyState();
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
                  final executed = context
                      .read<PeopleCardsBloc>()
                      .superLikeUser(user.userId);
                  if (executed) {
                    _cardSwiperController.swipe(CardSwiperDirection.top);
                  }
                },
                onDm: (_) {},
              );
            },
          );
        },
      ),
    );
  }
}

class _EventPeopleEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "No one here yet.\nCheck back closer to the event.",
            style: AppTheme.headingFour,
            textAlign: TextAlign.center,
          ),
          const Gap(16.0),
          GlintElevatedButton(
            label: "Go Back",
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
