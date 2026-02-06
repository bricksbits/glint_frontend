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
    context.read<PeopleCardsBloc>().setCardController(_cardSwiperController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final streamClient = StreamChat.of(context).client;
    return BlocListener<PeopleCardsBloc, PeopleCardsState>(
      listenWhen: (pre, curr) => curr.error.isNotEmpty,
      listener: (context, state) {
        showCustomSnackbar(
          context,
          message: state.error,
          isError: true,
        );
      },
      child: BlocBuilder<PeopleCardsBloc, PeopleCardsState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.displayCards.isEmpty
                  ? _showEmptyState(context)
                  : CardSwiper(
                      key: ValueKey(state.lastActionWasUndo),
                      cardsCount: state.displayCards.length,
                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                        left: true,
                        right: true,
                        up: true,
                        down: false,
                      ),
                      controller: _cardSwiperController,
                      isLoop: false,
                      numberOfCardsDisplayed:
                          state.displayCards.length >= 2 ? 2 : 1,
                      onSwipe: (prevIndex, currentIndex, swipeDirection) {
                        // Use prevIndex to get the model of the card that was just swiped
                        final prevSwipedCard = state.displayCards[prevIndex];

                        switch (swipeDirection) {
                          case CardSwiperDirection.none:
                            return false;
                          case CardSwiperDirection.left:
                            GlintAnalyticService.onCardActionEvent(
                              GlintSwipeGestureAnalyticsEvents.LEFT,
                              false,
                            );
                            context.read<PeopleCardsBloc>().add(
                                  PeopleCardsEvent.onLeftSwiped(
                                    prevSwipedCard.userId,
                                  ),
                                );
                            break;
                          case CardSwiperDirection.right:
                            GlintAnalyticService.onCardActionEvent(
                              GlintSwipeGestureAnalyticsEvents.RIGHT,
                              false,
                            );
                            context.read<PeopleCardsBloc>().add(
                                  PeopleCardsEvent.onRightSwiped(
                                      prevSwipedCard.userId),
                                );
                            break;
                          case CardSwiperDirection.top:
                            return _superLikeUser(
                              context,
                              prevSwipedCard.userId,
                            );
                          case CardSwiperDirection.bottom:
                            return false;
                        }

                        // Triggers the Pagination
                        if (state.displayCards.length - (currentIndex ?? 0) <=
                            2) {
                          context.read<PeopleCardsBloc>().add(
                                const PeopleCardsEvent.fetchNextCards(),
                              );
                        }

                        return true;
                      },
                      onUndo:
                          (previousIndex, currentIndex, cardSwipeDirection) {
                        context
                            .read<PeopleCardsBloc>()
                            .add(const PeopleCardsEvent.undo());
                        return true;
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        if (index >= state.displayCards.length) {
                          return _showEmptyState(context);
                        }
                        final user = state.displayCards[index];
                        return ScrollableProfileView(
                          key: ObjectKey(user.userId),
                          peopleUiModel: user,
                          onLiked: (userId) {
                            debugLogger(
                                "Manual SWIPE", "UserId : $userId to Right");
                            _cardSwiperController
                                .swipe(CardSwiperDirection.right);
                          },
                          onDisLiked: (userId) {
                            debugLogger(
                                "Manual SWIPE", "UserId : $userId to Left");
                            _cardSwiperController
                                .swipe(CardSwiperDirection.left);
                          },
                          onDm: (userId) {
                            final isSuperDmAvailable = context
                                .read<UserInfoManagerCubit>()
                                .superDmClicked();
                            if (isSuperDmAvailable) {
                              GlintAnalyticService.onCardActionEvent(
                                GlintSwipeGestureAnalyticsEvents.DM,
                                true,
                              );
                              SuperDmDialog.show(
                                context: context,
                                name: user.username,
                                bio: user.bio,
                                onSend: (message) {
                                  context
                                      .read<UserInfoManagerCubit>()
                                      .sendSuperDm(
                                        userId,
                                        message,
                                        streamClient,
                                      );
                                },
                              );
                            } else {
                              GlintAnalyticService.onCardActionEvent(
                                GlintSwipeGestureAnalyticsEvents.DM,
                                false,
                              );
                            }
                          },
                          onSuperLiked: (userId) {
                            _cardSwiperController
                                .swipe(CardSwiperDirection.top);
                          },
                        );
                      },
                    );
        },
      ),
    );
  }

  int numberOfCardsToBeDisplayed(int currentCardsAvailable) {
    if (currentCardsAvailable >= 2) {
      return 2;
    } else if (currentCardsAvailable == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  bool _superLikeUser(
    BuildContext passedContext,
    String userId,
  ) {
    final isSuperLikesAvailable =
        context.read<UserInfoManagerCubit>().superLikeClicked();

    if (isSuperLikesAvailable) {
      GlintAnalyticService.onCardActionEvent(
        GlintSwipeGestureAnalyticsEvents.SUPER,
        true,
      );
      context.read<PeopleCardsBloc>().add(
            PeopleCardsEvent.onSuperLiked(
              userId,
            ),
          );
      _cardSwiperController.swipe(
        CardSwiperDirection.top,
      );
      context.read<UserInfoManagerCubit>().superLikedUsed();
      return true;
    } else {
      GlintAnalyticService.onCardActionEvent(
        GlintSwipeGestureAnalyticsEvents.SUPER,
        false,
      );
      return false;
    }
  }

  Widget _showEmptyState(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Its a little quiet here",
            style: AppTheme.headingOne,
          ),
          const SizedBox(
            height: 16,
          ),
          GlintElevatedButton(
            label: "Adjust Search for better results",
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
