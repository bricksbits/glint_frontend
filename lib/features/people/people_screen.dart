import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';

class PeopleScreen extends StatelessWidget {
  PeopleScreen({super.key});

  final CardSwiperController cardSwiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    late PeopleCardModel currentVisibleModel;
    return BlocBuilder<PeopleCardsBloc, PeopleCardsState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.cardList.isNotEmpty
                ? CardSwiper(
                    allowedSwipeDirection: const AllowedSwipeDirection.only(
                      left: true,
                      right: true,
                      up: false,
                      down: false,
                    ),
                    onSwipe: (prev, current, swipeDirection) {
                      var lastUser = state.cardList.last;
                      switch (swipeDirection) {
                        case CardSwiperDirection.none:
                          return false;
                        case CardSwiperDirection.left:
                          context.read<PeopleCardsBloc>().add(
                              PeopleCardsEvent.onLeftSwiped(
                                  currentVisibleModel.userId));
                          if (currentVisibleModel.userId == lastUser.userId) {
                            context
                                .read<PeopleCardsBloc>()
                                .add(const PeopleCardsEvent.emptyCardList());
                          }
                          return true;
                        case CardSwiperDirection.right:
                          context.read<PeopleCardsBloc>().add(
                              PeopleCardsEvent.onRightSwiped(
                                  currentVisibleModel.userId));
                          if (currentVisibleModel.userId == lastUser.userId) {
                            context
                                .read<PeopleCardsBloc>()
                                .add(const PeopleCardsEvent.emptyCardList());
                          }
                          return true;
                        case CardSwiperDirection.top:
                          return false;
                        case CardSwiperDirection.bottom:
                          return false;
                      }
                    },
                    controller: cardSwiperController,
                    numberOfCardsDisplayed: state.cardList.length > 3 ? 2 : 0,
                    onUndo: (previousIndex, currentIndex, cardSwipeDirection) {
                      if (cardSwipeDirection == CardSwiperDirection.left &&
                          previousIndex != null) {}
                      return false;
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    isLoop: false,
                    cardsCount: state.cardList.length,
                    cardBuilder:
                        (context, index, percentThresholdX, percentThresholdY) {
                      currentVisibleModel = state.cardList[index];
                      return ScrollableProfileView(
                        peopleUiModel: currentVisibleModel,
                        onLiked: (userId) {},
                        onDisLiked: (userId) {},
                        onDm: (userId) {},
                        onSuperLiked: (userId) {},
                      );
                    },
                  )
                : state.isFetchingMoreProfile
                    ? const Center(
                        child: Text("Fetching more profiles just for you"),
                      )
                    : const Center(
                        child: Text("Its a little quiet here"),
                      );
      },
    );
  }
}
