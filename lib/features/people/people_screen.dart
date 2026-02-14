import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glint_frontend/analytics/glint_analytics_events.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/components/exports.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/design/components/profile/super_dm_dialog.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/user_info/user_info_manager_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final CardSwiperController _cardSwiperController = CardSwiperController();

  @override
  void initState() {
    context.read<PeopleCardsBloc>().add(
          PeopleCardsEvent.setupSwipeController(_cardSwiperController),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final streamClient = StreamChat.of(context).client;
    return Scaffold(
      body: BlocConsumer<PeopleCardsBloc, PeopleCardsState>(
        // Error changes (e.g. "nothing to undo") should NOT trigger a rebuild.
        buildWhen: (prev, curr) =>
            prev.displayCards != curr.displayCards ||
            prev.currentIndex != curr.currentIndex ||
            prev.isLoading != curr.isLoading,

        listenWhen: (prev, curr) =>
            curr.error != null && prev.error != curr.error,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        },

        builder: (context, state) {
          final remainingCards = state.displayCards.length - state.currentIndex;
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (remainingCards == 0) {
            return _showEmptyState(context);
          }

          return CardSwiper(
            // ── Stability ────────────────────────────────────────────────────────
            // A constant key — never rebuild this widget from scratch.
            // Undo is handled by controller.undo(), NOT by toggling a ValueKey.
            key: const ValueKey('people_card_swiper'),

            // ── Data ─────────────────────────────────────────────────────────────
            cardsCount: state.displayCards.length,
            initialIndex: state.currentIndex,

            // ── Undo visual config ────────────────────────────────────────────────
            showBackCardOnUndo: true,
            // Fly-back animation
            numberOfCardsDisplayed: remainingCards >= 2 ? 2 : 1,

            // ── Swipe config ─────────────────────────────────────────────────────
            allowedSwipeDirection: const AllowedSwipeDirection.only(
              left: true,
              right: true,
              up: true,
              down: false,
            ),
            controller: _cardSwiperController,
            isLoop: false,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),

            // ── Swipe callback ────────────────────────────────────────────────────
            onSwipe: (prevIndex, currentIndex, direction) {
              // prevIndex = the card that just left the screen
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

            // ── Undo callback ─────────────────────────────────────────────────────
            // The library calls this AFTER playing the fly-back animation.
            // We just tell the Bloc to decrement its index to stay in sync.
            onUndo: (previousIndex, currentIndex, direction) {
              context
                  .read<PeopleCardsBloc>()
                  .add(const PeopleCardsEvent.undo());
              return true;
            },

            // ── Card builder ──────────────────────────────────────────────────────
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) {
              if (index >= state.displayCards.length) {
                return _showEmptyState(context);
              }

              final user = state.displayCards[index];

              return ScrollableProfileView(
                key: ObjectKey(user.userId),
                peopleUiModel: user,
                // Button taps just trigger the controller — identical to a physical swipe.
                // The controller fires onSwipe, which fires the Bloc event. One path only.
                onLiked: (_) =>
                    _cardSwiperController.swipe(CardSwiperDirection.right),
                onDisLiked: (_) =>
                    _cardSwiperController.swipe(CardSwiperDirection.left),
                onSuperLiked: (_) {
                  final executeSuperLikeIfAvailable = context
                      .read<PeopleCardsBloc>()
                      .superLikeUser(user.userId);
                  if (executeSuperLikeIfAvailable) {
                    _cardSwiperController.swipe(CardSwiperDirection.top);
                  }
                },
                onDm: (userId) => _handleDm(
                  context,
                  user,
                  userId,
                  streamClient,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _handleDm(
    BuildContext context,
    PeopleCardModel user,
    String userId,
    StreamChatClient streamClient,
  ) {
    final cubit = context.read<UserInfoManagerCubit>();
    final isAvailable = cubit.superDmClicked();

    GlintAnalyticService.onCardActionEvent(
      GlintSwipeGestureAnalyticsEvents.DM,
      isAvailable,
    );

    if (!isAvailable) return;

    SuperDmDialog.show(
      context: context,
      name: user.username,
      bio: user.bio,
      onSend: (message) => cubit.sendSuperDm(userId, message, streamClient),
    );
  }

  Widget _showEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Its a little quiet here\n,Adjust your preferences for better results.",
            style: AppTheme.headingFour,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          GlintElevatedButton(
            label: "Search",
            onPressed: () {
              context.pushNamed(
                GlintMainRoutes.filter.name,
              );
            },
          )
        ],
      ),
    );
  }
}
