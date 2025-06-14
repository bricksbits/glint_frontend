import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PeopleCardsBloc()..add(const PeopleCardsEvent.started()),
      child: BlocBuilder<PeopleCardsBloc, PeopleCardsState>(
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
                      numberOfCardsDisplayed: 1,
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
                              percentThresholdY) =>
                          ScrollableProfileView(
                              peopleUiModel: state.cardList[index]),
                    )
                  : const Center(
                      child: Text("Its a little quiet here"),
                    );
        },
      ),
    );
  }
}
