import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/shared/event_location_map_button.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/features/event/detail/event_detail_cubit.dart';
import 'package:glint_frontend/navigation/argument_models.dart';

/// For User Type Users : Just pass the event Id
/// For User Type Admin : pass the event Detail Model and file paths
/// For User Super Admin : pass the event Id,
class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({
    super.key,
    required this.eventArguments,
  });

  final EventDetailsNavArguments eventArguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EventDetailCubit()..getDetailsViaArguments(eventArguments),
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
                'Event Preview',
                style: eventArguments.unUploadedFiles != null
                    ? AppTheme.heavyBodyText
                    : AppTheme.headingTwo.copyWith(fontSize: 20.0),
              ),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, EventDetailState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.eventDetails == null) {
      return _ErrorState(
        message: state.errorMessage!,
        onRetry: () => context.read<EventDetailCubit>().retry(),
      );
    }

    final details = state.eventDetails;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageSection(state),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40.0),
                _EventTitle(title: details?.eventName ?? ""),
                const Gap(20.0),
                _EventDetails(
                  date: details?.eventdate ?? "",
                  time: details?.eventTime ?? "",
                  location: details?.eventLocation ?? "",
                ),
                const Gap(24.0),
                _EventPricing(
                  oldPrice: details?.eventOldPrice ?? "",
                  newPrice: details?.eventCurrentPrice ?? "",
                  daysLeft: details?.daysLeft ?? "",
                  discountActivated: details?.discountActivated ?? false,
                ),
                const Gap(24.0),
                _AboutEvent(eventDescription: details?.aboutEvent ?? ""),
              ],
            ),
          ),

          const Gap(24.0),

          // Event by
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Event is, ',
                      style: AppTheme.simpleText,
                    ),
                    TextSpan(
                      text: details?.eventBy,
                      style: AppTheme.simpleText.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Location map — shown when valid coordinates are available
          if (details != null &&
              (details.latitude != 0.0 || details.longitude != 0.0)) ...[
            const Gap(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Location',
                  style: AppTheme.simpleBodyText.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const Gap(8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: EventLocationMapButton(
                latitude: details.latitude,
                longitude: details.longitude,
                googleMapsUrl: details.googleMapUrl,
                height: 150.0,
              ),
            ),
          ],

          // Admin-only section
          if (details != null && details.isAdminView) ...[
            const Gap(24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _AdminEventDetails(details: details),
            ),
          ],

          const Gap(20.0),
        ],
      ),
    );
  }

  Widget _buildImageSection(EventDetailState state) {
    if (state.eventDetails?.eventCoverImageUrl != null &&
        state.eventDetails!.eventCoverImageUrl.isNotEmpty) {
      return CarouselSlider(
        options: CarouselOptions(
          height: 264,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: state.eventDetails!.eventCoverImageUrl.map((imageUrl) {
          return Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              'lib/assets/images/event/event_banner_placeholder.png',
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
      );
    }

    if (eventArguments.unUploadedFiles != null) {
      return CarouselSlider(
        options: CarouselOptions(
          height: 264,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: eventArguments.unUploadedFiles!
            .where((item) => item != null)
            .map((imageUrl) {
          return Image.file(
            imageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
          );
        }).toList(),
      );
    }

    return Image.asset(
      'lib/assets/images/event/event_banner_placeholder.png',
      fit: BoxFit.cover,
      height: 264,
      width: double.infinity,
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColours.gray),
            const Gap(16.0),
            Text(
              'Failed to load event details',
              style: AppTheme.simpleBodyText.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const Gap(8.0),
            Text(
              message,
              style: AppTheme.simpleText,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(24.0),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColours.primaryBlue,
                foregroundColor: AppColours.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
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
  final bool discountActivated;

  const _EventPricing({
    required this.oldPrice,
    required this.newPrice,
    required this.daysLeft,
    required this.discountActivated,
  });

  @override
  Widget build(BuildContext context) {
    final showDiscount = discountActivated && oldPrice.isNotEmpty && oldPrice != newPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDiscount)
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

class _AboutEvent extends StatelessWidget {
  const _AboutEvent({required this.eventDescription});

  final String eventDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'About Event',
          style: AppTheme.simpleBodyText.copyWith(fontWeight: FontWeight.w700),
        ),
        const Gap(6.0),
        Text(eventDescription, style: AppTheme.simpleText),
      ],
    );
  }
}

class _AdminEventDetails extends StatelessWidget {
  const _AdminEventDetails({required this.details});

  final EventDetailsDomainModel details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Management',
          style: AppTheme.simpleBodyText.copyWith(fontWeight: FontWeight.w700),
        ),
        const Gap(12.0),
        if (details.totalTickets != null)
          _AdminInfoRow(
            label: 'Tickets',
            value:
                '${details.ticketsRemaining ?? "—"} / ${details.totalTickets} remaining',
          ),
        if (details.approvalStatus != null)
          _AdminInfoRow(label: 'Status', value: details.approvalStatus!),
        if (details.isHotEvent == true)
          const _AdminInfoRow(label: 'Hot Event', value: '🔥 Yes'),
        if (details.confirmedTicketsCount != null)
          _AdminInfoRow(
            label: 'Confirmed',
            value: '${details.confirmedTicketsCount} ticket(s)',
          ),
        if (details.coordinatorEmail != null)
          _AdminInfoRow(
            label: 'Coordinator',
            value:
                '${details.coordinatorUsername ?? ""} · ${details.coordinatorEmail}',
          ),
        if (details.bookByTime != null)
          _AdminInfoRow(
            label: 'Book by',
            value: _formatDate(details.bookByTime!),
          ),
        if (details.categories != null && details.categories!.isNotEmpty)
          _AdminInfoRow(
            label: 'Categories',
            value: details.categories!.join(', '),
          ),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }
}

class _AdminInfoRow extends StatelessWidget {
  const _AdminInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTheme.simpleText.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColours.gray,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: AppTheme.simpleText),
          ),
        ],
      ),
    );
  }
}
