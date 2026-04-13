import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/chat/event_ticket_view.dart';
import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';

class ConfirmTicketScreen extends StatelessWidget {
  const ConfirmTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SingleChildScrollView(
        child: EventTicketView(
          eventName: 'New Year Jashn 2025',
          eventDate: '31st Dec 2024',
          eventTime: '7:00 PM',
          eventLocation: 'Shriram Business Park',
          couponCode: 'BHSP23JN',
          expiryDate: '1 January 2025',
          totalAmount: '499',
          googleMapsUrl: 'https://maps.google.com/maps?q=Shriram+Business+Park',
          latitude: 21.2514,
          longitude: 81.6296,
          bannerImageUrl: 'lib/assets/images/chat/chat_ticket_info_pace_holder.png',
          person1: UserTicketHolderModel(
            userId: '1',
            username: 'Shubham (You)',
            imageUrl: 'lib/assets/images/temp_place_holder.png',
          ),
          person2: UserTicketHolderModel(
            userId: '2',
            username: 'Gajgamini',
            imageUrl: 'lib/assets/images/temp_place_holder.png',
          ),
          onInfoClicked: () {},
          onClosedClicked: () {},
        ),
      ),
    );
  }
}
