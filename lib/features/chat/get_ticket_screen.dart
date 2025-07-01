import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/components/chat/common_ticket_banner.dart';
import 'package:glint_frontend/design/components/chat/ticket_details_component.dart';
import 'package:glint_frontend/design/components/exports.dart';
import 'package:glint_frontend/features/chat/model/get_ticket_argument_model.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import '../payment/model/payment_argument_model.dart';

class GetEventTicketScreen extends StatelessWidget {
  const GetEventTicketScreen({
    super.key,
    required this.getTicketArgumentModel,
  });

  final GetTicketArgumentModel getTicketArgumentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            color: AppColours.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white70,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Event Image
                CommonTicketBanner(
                  bannerImagerUrl: getTicketArgumentModel.eventBanner ??
                      'lib/assets/images/chat/chat_ticket_info_pace_holder.png',
                  onInfoClicked: () {},
                  onClosedClicked: () {},
                ),
                // Event Details
                TicketDetailsComponent(
                  eventName: getTicketArgumentModel.eventName,
                  eventDate: getTicketArgumentModel.eventDate,
                  eventTime: getTicketArgumentModel.eventTime,
                  eventLocation: getTicketArgumentModel.eventLocation,
                  eventInitialPrice: getTicketArgumentModel.eventInitialPrice,
                  eventFinalPrice: getTicketArgumentModel.eventFinalPrice,
                  dayLeftForEvent: getTicketArgumentModel.dayLeftForEvent,
                ),
                // Divider
                const Gap(24.0),
                // ticket icon
                Container(
                  height: 60.0,
                  width: 60.0,
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: AppColours.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColours.borderGray,
                      width: 2.0,
                    ),
                  ),
                  child: SvgPicture.asset('lib/assets/icons/glint-ticket.svg'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'Choose your ticket payment option',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "AlbertSans"),
                  ),
                ),
                // Payment Buttons
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 52.0,
                  child: GlintIconElevatedButton(
                    backgroundColor: AppColours.black,
                    foregroundColor: AppColours.white,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                            'lib/assets/icons/pay_for_both_icon.svg'),
                        const Gap(12.0),
                        const Text('Pay for Both'),
                      ],
                    ),
                    onPressed: () {
                      context.pushNamed(
                        GlintMainRoutes.payment.name,
                        extra: PaymentArgumentModel(
                          membershipType: null,
                          amountOfSelectedMembership: null,
                          timePeriod: null,
                          eventId: getTicketArgumentModel.eventId,
                          matchId: getTicketArgumentModel.matchId,
                          userOne: getTicketArgumentModel.currentUser,
                          userTwo: getTicketArgumentModel.matchedUser,
                          eventTicketPrice: getTicketArgumentModel.eventFinalPrice,
                        ),
                      );
                    },
                  ),
                ),
                const Gap(16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 52.0,
                  child: GlintIconElevatedButton(
                    backgroundColor: AppColours.black,
                    foregroundColor: AppColours.white,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                            'lib/assets/icons/split_payment_icon.svg'),
                        const Gap(12.0),
                        const Text('Split Payment'),
                      ],
                    ),
                    onPressed: () {
                      //Todo: Show a Snackbar that, is not available will be add up in the future,
                    },
                  ),
                ),
                const Gap(48.0),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTheme.smallBodyText.copyWith(
                        fontSize: 10.0,
                        color: AppColours.black,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Note : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Tickets will be sent to the person who makes the payment.',
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
