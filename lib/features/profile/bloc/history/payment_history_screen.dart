import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/profile/bloc/history/payment_history_cubit.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentHistoryCubit(),
      child: BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColours.white,
              title: const Text(
                "Payment History",
                style: AppTheme.simpleBodyText,
              ),
            ),
            body: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.error.isNotEmpty
                    ? const Center(
                        child: Text(
                          "Due to Server Failure, please try again later.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : CustomScrollView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // live event chip
                                  ChoiceChip(
                                    onSelected: (bool? value) {
                                      GlintAnalyticService
                                          .onPaymentHistoryTabEvent("all");
                                      context
                                          .read<PaymentHistoryCubit>()
                                          .selectAll();
                                    },
                                    selected: state.currentSelectedChip ==
                                        PaymentHistoryEnums.ALL,
                                    showCheckmark: false,
                                    labelStyle: AppTheme.simpleText,
                                    selectedColor: AppColours.backgroundShade,
                                    backgroundColor: AppColours.white,
                                    label: const Text(
                                      'All',
                                      style: AppTheme.simpleText,
                                    ),
                                    shape: const StadiumBorder(
                                      side: BorderSide(
                                        color: AppColours.backgroundShade,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  const Gap(12.0),
                                  ChoiceChip(
                                    onSelected: (bool? value) {
                                      GlintAnalyticService
                                          .onPaymentHistoryTabEvent("events");
                                      context
                                          .read<PaymentHistoryCubit>()
                                          .selectEvent();
                                    },
                                    selected: state.currentSelectedChip ==
                                        PaymentHistoryEnums.EVENTS,
                                    showCheckmark: false,
                                    labelStyle: AppTheme.simpleText,
                                    selectedColor: AppColours.backgroundShade,
                                    backgroundColor: AppColours.white,
                                    label: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Event',
                                          style: AppTheme.simpleText,
                                        ),
                                      ],
                                    ),
                                    shape: const StadiumBorder(
                                      side: BorderSide(
                                        color: AppColours.backgroundShade,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  const Gap(12.0),
                                  ChoiceChip(
                                    onSelected: (bool? value) {
                                      GlintAnalyticService
                                          .onPaymentHistoryTabEvent(
                                              "membership");
                                      context
                                          .read<PaymentHistoryCubit>()
                                          .selectMembership();
                                    },
                                    selected: state.currentSelectedChip ==
                                        PaymentHistoryEnums.MEMBERSHIP,
                                    showCheckmark: false,
                                    labelStyle: AppTheme.simpleText,
                                    selectedColor: AppColours.backgroundShade,
                                    backgroundColor: AppColours.white,
                                    label: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Membership',
                                          style: AppTheme.simpleText,
                                        ),
                                      ],
                                    ),
                                    shape: const StadiumBorder(
                                      side: BorderSide(
                                        color: AppColours.backgroundShade,
                                        width: 1.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gap(16.0),
                            Divider(
                              thickness: 0.6,
                              color: AppColours.mediumGray,
                            ),
                          ],
                        ),
                      ),
                      state.currentSelectedList.isEmpty
                          ? const SliverToBoxAdapter(
                              child: Center(
                                child: Text(
                                    "No Data available, Please spend some money for us. :)"),
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildListDelegate(
                                state.currentSelectedList
                                    .map(
                                      (item) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: buildEventListItem(
                                          icon: Icons.event,
                                          title: item.historyTitle,
                                          subtitle:
                                              "${item.date} * ${item.time}",
                                          price: item.amount,
                                          orderId: item.orderId,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget buildEventListItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String price,
    required String orderId,
  }) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          // Background color for the icon container
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Icon(
          icon,
          color: Colors.deepPurple, // Icon color
          size: 28,
        ),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '₹$price',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            'ORD ID : $orderId',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
