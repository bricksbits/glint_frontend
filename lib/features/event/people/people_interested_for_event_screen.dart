import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glint_frontend/design/components/glint_app_bar.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/navigation/argument_models.dart';

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
  final CardSwiperController cardSwiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlintAppBar(
        appBarAction: GlintAppBarActions.eventProfile,
        eventName: widget.navArguments.eventName,
        eventTimeLeft: widget.navArguments.eventDaysLeft,
      ),
      body: BlocBuilder<PeopleCardsBloc, PeopleCardsState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.cardList.isEmpty
                  ? const Center(
                      child: Text(
                          "No Profile yet, please try again little later,"),
                    )
                  : state.cardList.isNotEmpty
                      ? CardSwiper(
                          allowedSwipeDirection:
                              const AllowedSwipeDirection.only(
                            left: true,
                            right: true,
                            up: false,
                            down: false,
                          ),
                          onSwipe: (prev, current, swipeDirection) {
                            if (current != null) {
                              var fetchedUser =
                                  state.cardList.elementAt(current);
                              switch (swipeDirection) {
                                case CardSwiperDirection.none:
                                  return false;
                                case CardSwiperDirection.left:
                                  context.read<PeopleCardsBloc>().add(
                                      PeopleCardsEvent.onLeftSwiped(
                                          fetchedUser.userId));
                                  return true;
                                case CardSwiperDirection.right:
                                  context.read<PeopleCardsBloc>().add(
                                      PeopleCardsEvent.onRightSwiped(
                                          fetchedUser.userId));
                                  return true;
                                case CardSwiperDirection.top:
                                  return false;
                                case CardSwiperDirection.bottom:
                                  return false;
                              }
                            } else {
                              return false;
                            }
                          },
                          controller: cardSwiperController,
                          numberOfCardsDisplayed: 1,
                          onUndo: (previousIndex, currentIndex,
                              cardSwipeDirection) {
                            if (cardSwipeDirection ==
                                    CardSwiperDirection.left &&
                                previousIndex != null) {}
                            return false;
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          isLoop: false,
                          cardsCount: state.cardList.length,
                          cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) =>
                              ScrollableProfileView(
                            peopleUiModel: state.cardList[index],
                            onLiked: (userId) {},
                            onDisLiked: (userId) {},
                            onDm: (userId) {},
                            onSuperLiked: (userId) {},
                          ),
                        )
                      : const Center(
                          child: Text("Its a little quiet here"),
                        );
        },
      ),
    );
  }
}
