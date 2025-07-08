import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/features/event/detail/event_detail_cubit.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({
    super.key,
    required this.isEventPreviewType,
    this.isSuperAdmin = false,
    this.eventListDomainModel,
  });

  final bool isEventPreviewType;
  final bool isSuperAdmin;
  final EventListDomainModel? eventListDomainModel;

  @override
  Widget build(BuildContext context) {
    const interactedUsers = [
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
    ];
    return BlocProvider(
      create: (context) => EventDetailCubit(),
      child: BlocBuilder<EventDetailCubit, EventDetailState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColours.white,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: AppColours.white,
              centerTitle: state.isEventPreviewForAdmin ? false : true,
              scrolledUnderElevation: 0,
              title: Text(
                state.isEventPreviewForAdmin
                    ? isSuperAdmin
                        ? 'Event Request'
                        : 'Event Preview'
                    : 'Event',
                style: (state.isEventPreviewForAdmin || isSuperAdmin)
                    ? AppTheme.heavyBodyText
                    : AppTheme.headingTwo.copyWith(fontSize: 20.0),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (state.isEventPreviewForAdmin) const Gap(12.0),
                  // event image
                  if (!state.isEventPreviewForAdmin)
                    _EventImage(
                        imageUrl:
                            state.eventDetails?.eventCoverImageUrl.first ?? ""),

                  // todo - Implement state here for admin event profile
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 264,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                    items:
                        state.eventDetails?.eventCoverImageUrl.map((imageUrl) {
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    }).toList(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(40.0),
                        _EventTitle(title: state.eventDetails?.eventName ?? ""),
                        const Gap(20.0),
                        _EventDetails(
                          date: state.eventDetails?.eventdate ?? "",
                          time: state.eventDetails?.eventTime ?? "",
                          location: state.eventDetails?.eventLocation ?? "",
                        ),
                        const Gap(24.0),
                        _EventPricing(
                          oldPrice: state.eventDetails?.eventOldPrice ?? "",
                          newPrice: state.eventDetails?.eventCurrentPrice ?? "",
                          daysLeft: state.eventDetails?.daysLeft ?? "",
                        ),
                      ],
                    ),
                  ),

                  const Gap(32.0),

                  // interested profiles
                  _BuildInterestedProfiles(
                    interestedProfiles: interactedUsers,
                    showProfileIconsOnly: state.isEventPreviewForAdmin,
                  ),

                  const Gap(32.0),

                  // about event
                  _AboutEvent(
                    eventDescription: state.eventDetails?.aboutEvent ?? "",
                  ),

                  // todo - implement Map (event location) ui here

                  const Gap(32.0),

                  // event by
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Event by ',
                              style: AppTheme.simpleText,
                            ),
                            TextSpan(
                              text: state.eventDetails?.eventBy,
                              style: AppTheme.simpleText.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isSuperAdmin) ...[
                    const Gap(12.0),
                    const Divider(
                      color: AppColours.mediumGray,
                      thickness: 0.5,
                    ),
                    const Gap(8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 44.0,
                              child: GlintElevatedButton(
                                label: 'Accept',
                                customBorderRadius: 10.0,
                                customTextStyle: AppTheme.simpleText.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColours.white,
                                ),
                                onPressed: () {
                                  // todo - implement super admin accept functionality
                                },
                              ),
                            ),
                          ),
                          const Gap(12.0),
                          Expanded(
                            child: SizedBox(
                              height: 44.0,
                              child: GlintElevatedButton(
                                label: 'Reject',
                                customBorderRadius: 10.0,
                                backgroundColor: AppColours.white,
                                customBorderSide: const BorderSide(
                                  color: AppColours.rejectedColor,
                                  width: 1.0,
                                ),
                                customTextStyle: AppTheme.simpleText.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColours.rejectedColor,
                                ),
                                onPressed: () {
                                  // todo - implement super admin reject functionality
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  // end of the page gap for design replication purpose
                  const Gap(20.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EventImage extends StatelessWidget {
  final String imageUrl;

  const _EventImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280.0,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _EventTitle extends StatelessWidget {
  final String title;

  const _EventTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTheme.headingTwo.copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}

class _EventDetails extends StatelessWidget {
  final String date;
  final String time;
  final String location;

  const _EventDetails({
    required this.date,
    required this.time,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlintIconLabel(
          iconPath: 'lib/assets/icons/calendar_icon.svg',
          label: '$date - $time',
          style: AppTheme.simpleText,
        ),
        const Gap(8.0),
        GlintIconLabel(
          iconPath: 'lib/assets/icons/location_icon.svg',
          label: location,
          style: AppTheme.simpleText,
        ),
      ],
    );
  }
}

class _EventPricing extends StatelessWidget {
  final String oldPrice;
  final String newPrice;
  final String daysLeft;

  const _EventPricing({
    required this.oldPrice,
    required this.newPrice,
    required this.daysLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('₹ ', style: AppTheme.simpleText),
            Text(
              oldPrice,
              style: AppTheme.simpleText.copyWith(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '₹ $newPrice',
                    style: const TextStyle(
                      fontFamily: 'AlbertSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: AppColours.primaryBlue,
                    ),
                  ),
                  const TextSpan(
                    text: ' / person',
                    style: TextStyle(
                      fontFamily: 'AlbertSans',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: AppColours.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8.0),
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
                '$daysLeft days left',
                style: const TextStyle(
                  fontFamily: 'AlbertSans',
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  color: AppColours.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BuildInterestedProfiles extends StatelessWidget {
  const _BuildInterestedProfiles(
      {required this.interestedProfiles, required this.showProfileIconsOnly});

  final List<String> interestedProfiles;
  final bool showProfileIconsOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: const BoxDecoration(
        color: AppColours.black,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...interestedProfiles.map(
            (userImage) => Align(
              widthFactor: 0.5,
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CircleAvatar(
                  radius: 10.0,
                  backgroundImage:
                      showProfileIconsOnly ? null : NetworkImage(userImage),
                  backgroundColor:
                      showProfileIconsOnly ? AppColours.gray : null,
                  child: showProfileIconsOnly
                      ? const Icon(
                          Icons.person,
                          color: AppColours.white,
                          size: 16.0,
                        )
                      : null,
                ),
              ),
            ),
          ),
          const Gap(20.0),
          Text(
            'See interested profiles',
            style: AppTheme.simpleText.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColours.white,
            ),
          ),
          const Gap(2.0),
          const Icon(
            Icons.chevron_right,
            color: AppColours.warning300,
          ),
        ],
      ),
    );
  }
}

class _AboutEvent extends StatelessWidget {
  const _AboutEvent({
    required this.eventDescription,
  });

  final String eventDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Event',
            style: AppTheme.simpleBodyText.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(6.0),
          Text(
            eventDescription,
            style: AppTheme.simpleText,
          ),
        ],
      ),
    );
  }
}
