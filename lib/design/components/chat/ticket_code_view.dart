import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class TicketCodeView extends StatelessWidget {
  const TicketCodeView({
    super.key,
    required this.couponCode,
    required this.expiryDate,
  });

  final String couponCode;
  final String expiryDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GlintGradientTextWidget(
          text: couponCode,
          gradient: AppColours.ticketCouponBackgroundGradient,
          style: const TextStyle(
            fontFamily: 'AlbertSans',
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const Gap(20.0),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.4,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Ticket will be verified at the event through',
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.white,
                  ),
                ),
                TextSpan(
                  text: ' Glint App',
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(12.0),
        const Divider(
          thickness: 1.2,
        ),
        const Gap(12.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Expiry Date : ',
                style: AppTheme.smallBodyText.copyWith(
                  color: AppColours.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: expiryDate,
                style: AppTheme.smallBodyText.copyWith(
                  color: AppColours.white,
                ),
              ),
            ],
          ),
        ),
        const Gap(8.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Note : ',
                style: AppTheme.smallBodyText.copyWith(
                  color: AppColours.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'This is a Non–Transferrable Ticket',
                style: AppTheme.smallBodyText.copyWith(
                  color: AppColours.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
