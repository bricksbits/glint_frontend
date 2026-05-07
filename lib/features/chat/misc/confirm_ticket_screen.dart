import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/chat/event_ticket_view.dart';
import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';
import 'package:glint_frontend/features/chat/misc/confirm_ticket_cubit.dart';
import 'package:glint_frontend/navigation/argument_models.dart';

class ConfirmTicketScreen extends StatefulWidget {
  final ConfirmTicketNavArguments navArguments;

  const ConfirmTicketScreen({super.key, required this.navArguments});

  @override
  State<ConfirmTicketScreen> createState() => _ConfirmTicketScreenState();
}

class _ConfirmTicketScreenState extends State<ConfirmTicketScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ConfirmTicketCubit>().init(widget.navArguments);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmTicketCubit, ConfirmTicketState>(
      builder: (context, state) {
        final appBar = AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: AppColours.white,
          scrolledUnderElevation: 0,
        );

        if (state.isLoading) {
          return Scaffold(
            backgroundColor: AppColours.white,
            appBar: appBar,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.error != null && state.eventDetails == null) {
          return Scaffold(
            backgroundColor: AppColours.white,
            appBar: appBar,
            body: Center(child: Text(state.error!)),
          );
        }

        final eventDetails = state.eventDetails;
        if (eventDetails == null) {
          return Scaffold(
            backgroundColor: AppColours.white,
            appBar: appBar,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final lat =
            double.tryParse(eventDetails.location["lat"] ?? "0") ?? 0.0;
        final long =
            double.tryParse(eventDetails.location["long"] ?? "0") ?? 0.0;
        final googleMapsUrl =
            "https://maps.google.com/maps?q=$lat,$long";
        final bannerImageUrl = eventDetails.eventCoverImageUrl.isNotEmpty
            ? eventDetails.eventCoverImageUrl.first
            : 'lib/assets/images/chat/chat_ticket_info_pace_holder.png';

        return Scaffold(
          backgroundColor: AppColours.white,
          appBar: appBar,
          body: SingleChildScrollView(
            child: EventTicketView(
              eventName: eventDetails.eventName,
              eventDate: eventDetails.eventdate,
              eventTime: eventDetails.eventTime,
              eventLocation: eventDetails.eventLocation,
              couponCode: state.couponCode ?? "",
              expiryDate: eventDetails.eventdate,
              totalAmount: state.totalAmount ?? "",
              googleMapsUrl: googleMapsUrl,
              latitude: lat,
              longitude: long,
              bannerImageUrl: bannerImageUrl,
              person1: state.currentUser ??
                  UserTicketHolderModel(
                    userId: "",
                    username: "You",
                    imageUrl: "",
                  ),
              person2: state.matchedUser ??
                  UserTicketHolderModel(
                    userId: "",
                    username: "Partner",
                    imageUrl: "",
                  ),
              onInfoClicked: () {},
              onClosedClicked: () {},
            ),
          ),
        );
      },
    );
  }
}
