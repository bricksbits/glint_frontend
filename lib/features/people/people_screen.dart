import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/logger.dart';

class PeopleScreen extends StatelessWidget {
  PeopleScreen({super.key});

  final CardSwiperController cardSwiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleCardsBloc, PeopleCardsState>(
      builder: (context, state) {
        debugLogger("PeopleScreen: CardList", "${state.cardList.length}");
        final remainingCards = state.cardList
            .where((card) => !state.alreadySwipedId.contains(card.userId))
            .toList();
        debugLogger("PeopleScreen : RemainingList", "${remainingCards.length}");
        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : remainingCards.isEmpty
                ? const Center(
                    child: Text("Its a little quiet here"),
                  )
                : state.cardList.isNotEmpty && remainingCards.isNotEmpty
                    ? CardSwiper(
                        allowedSwipeDirection: const AllowedSwipeDirection.only(
                          left: true,
                          right: true,
                          up: false,
                          down: false,
                        ),
                        onSwipe: (prevIndex, currentIndex, swipeDirection) {
                          // Use prevIndex to get the model of the card that was just swiped
                          final prevSwipedCard = state.cardList[prevIndex];

                          // Use currentIndex to see what the next card is, or null if the list is empty
                          final nextCardExists = (currentIndex != null &&
                              currentIndex < state.cardList.length);
                          final lastCardIsSwiped =
                              (prevIndex == state.cardList.length - 1);

                          switch (swipeDirection) {
                            case CardSwiperDirection.none:
                              return false;
                            case CardSwiperDirection.left:
                              context.read<PeopleCardsBloc>().add(
                                    PeopleCardsEvent.onLeftSwiped(
                                      prevSwipedCard.userId,
                                    ),
                                  );
                              break;
                            case CardSwiperDirection.right:
                              context.read<PeopleCardsBloc>().add(
                                    PeopleCardsEvent.onRightSwiped(
                                        prevSwipedCard.userId),
                                  );
                              break;
                            case CardSwiperDirection.top:
                              return false;
                            case CardSwiperDirection.bottom:
                              return false;
                          }

                          // Trigger pagination or empty screen logic based on the list's state
                          if (!nextCardExists && lastCardIsSwiped) {
                            context
                                .read<PeopleCardsBloc>()
                                .add(const PeopleCardsEvent.emptyCardList());
                          } else if (state.cardList.length -
                                  (currentIndex ?? 0) <=
                              3) {
                            context.read<PeopleCardsBloc>().add(
                                  const PeopleCardsEvent.fetchNextCards(),
                                );
                          }

                          return true;
                        },
                        controller: cardSwiperController,
                        numberOfCardsDisplayed:
                            numberOfCardsToBeDisplayed(state.cardList.length),
                        onUndo:
                            (previousIndex, currentIndex, cardSwipeDirection) {
                          if (cardSwipeDirection == CardSwiperDirection.left &&
                              previousIndex != null) {}
                          return false;
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        isLoop: false,
                        cardsCount: state.cardList.length,
                        cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) {
                          debugLogger("PeopleScreen",
                              "On show Id : ${state.cardList[index].userId}");
                          return ScrollableProfileView(
                            peopleUiModel: state.cardList[index],
                            onLiked: (userId) {
                              debugLogger(
                                  "Manual SWIPE", "UserId : $userId to Right");
                              cardSwiperController
                                  .swipe(CardSwiperDirection.right);
                            },
                            onDisLiked: (userId) {
                              debugLogger(
                                  "Manual SWIPE", "UserId : $userId to LEft");
                              cardSwiperController
                                  .swipe(CardSwiperDirection.left);
                            },
                            onDm: (userId) {},
                            onSuperLiked: (userId) {
                              context.read<PeopleCardsBloc>().add(
                                    PeopleCardsEvent.onSuperLiked(
                                      userId,
                                    ),
                                  );
                              cardSwiperController
                                  .swipe(CardSwiperDirection.right);
                            },
                          );
                        },
                      )
                    : state.isFetchingMoreProfile
                        ? const Center(
                            child: Text("Fetching more profiles just for you"),
                          )
                        : const Center(
                            child: Text("Something Went Wrong"),
                          );
      },
    );
  }

  int numberOfCardsToBeDisplayed(int currentCardsAvailable) {
    if (currentCardsAvailable > 3) {
      return 2;
    } else if (currentCardsAvailable > 1) {
      return 1;
    } else {
      return 0;
    }
  }
}
