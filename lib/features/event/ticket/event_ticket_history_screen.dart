import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class EventTicketHistoryScreen extends StatelessWidget {
  const EventTicketHistoryScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              _buildTicketHistoryWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketHistoryWidget(BuildContext context) {
    const cardHeight = 148.0;
    final screenSize = MediaQuery.of(context).size;
    const eventName = 'The Local Food Fest';
    const eventDate = '20 Feb 2023';
    const eventImage =
        'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D';
    const eventLocation = 'Shriram business park';
    const eventHasPassed = false;
    const eventDaysLeft = 7;
    const interactedUsers = [
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
    ];
    return Stack(
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
                    Text(
                      eventName,
                      style: AppTheme.headingFour.copyWith(
                        fontStyle: FontStyle.normal,
                        color: AppColours.black,
                        fontWeight: FontWeight.w400,
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
                        child: const Text(
                          '$eventDaysLeft days left',
                          style: TextStyle(
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
                      label: eventDate,
                      style: AppTheme.simpleText.copyWith(
                        fontSize: 12.0,
                        color: AppColours.black,
                      ),
                    ),
                    const Gap(8.0),
                    GlintIconLabel(
                      iconPath: 'lib/assets/icons/location_icon.svg',
                      svgColor: AppColours.primaryBlue,
                      label: eventLocation,
                      style: AppTheme.simpleText.copyWith(
                        fontSize: 12.0,
                        color: AppColours.black,
                      ),
                    ),
                  ],
                ),

                // boy and girl
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
                    Text(
                      'You & Shalini',
                      style: AppTheme.smallBodyText.copyWith(
                        color: AppColours.black,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),

                // event image overlay container
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(eventImage),
                fit: BoxFit.cover,
              ),
              border: Border(
                left: BorderSide(
                  color: AppColours.white,
                  width: 1.5,
                ),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
