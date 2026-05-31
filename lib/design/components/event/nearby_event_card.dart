import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';

class NearbyEventCard extends StatelessWidget {
  const NearbyEventCard({
    super.key,
    required this.eventModel,
    required this.fetchProfiles,
    required this.getEventInfo,
  });

  final EventListDomainModel eventModel;
  final Function(String) fetchProfiles;
  final Function(String) getEventInfo;

  static const double _imageWidth = 120.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => fetchProfiles(eventModel.eventId),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: AppColours.chipBackgroundShade),
            color: AppColours.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              // Left content, padded to leave room for the image
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 20.0, _imageWidth + 16.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventModel.eventName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.headingFour.copyWith(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Gap(12.0),
                    GlintIconLabel(
                      iconPath: 'lib/assets/icons/calendar_icon.svg',
                      label: eventModel.eventdate,
                      style: AppTheme.simpleText.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Gap(8.0),
                    const GlintIconLabel(
                      iconPath: 'lib/assets/icons/location_icon.svg',
                      label: 'Tap info button',
                      style: AppTheme.simpleText,
                    ),
                    const Gap(12.0),
                    // Price and days left stacked vertically
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹ ${eventModel.eventCurrentPrice}',
                          style: AppTheme.heavyBodyText.copyWith(
                            color: AppColours.black,
                          ),
                        ),
                        const Gap(4.0),
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
                            '${eventModel.daysLeft} days left',
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
                ),
              ),

              // Image — right side, fills full card height
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: SizedBox(
                  width: _imageWidth,
                  child: FadeInImage.assetNetwork(
                    image: eventModel.eventCoverImageUrl.isNotEmpty
                        ? eventModel.eventCoverImageUrl
                        : 'https://via.placeholder.com/120',
                    placeholder:
                        'lib/assets/images/event/event_banner_placeholder.png',
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'lib/assets/images/event/event_banner_placeholder.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),

              // Info icon — top-right corner of the image
              Positioned(
                right: 8.0,
                top: 8.0,
                child: GestureDetector(
                  onTap: () => getEventInfo(eventModel.eventId),
                  child: SvgPicture.asset(
                    'lib/assets/icons/info_icon.svg',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
