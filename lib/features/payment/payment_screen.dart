import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/features/payment/model/payment_argument_model.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.paymentArgumentModel,
  });

  final PaymentArgumentModel? paymentArgumentModel;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  //Todo(GO): Inject Razorpay Instance
  //Todo(GO): Support for the Different UPI apps on IOS and Android.
  final Razorpay _razorpay = Razorpay();

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context
        .read<PaymentCubit>()
        .collectPaymentRequest(widget.paymentArgumentModel);

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWalletAdded);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        state.when(initiate: (orderId, amount, name, desc, razorPayModel,
            paymentModel, loading, isMembership, error) {
          if (razorPayModel != null) {
            print("Success Order Placed, opening razorpay");
            _razorpay.open(razorPayModel.toJson());
          }
        });
      },
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: const Icon(Icons.arrow_back, color: Colors.black),
              title: const Text(
                'Payment',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
            body: state.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        _upperTicketView(state),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Amount to be paid',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        '₹ ${state.totalAmount}',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    backgroundColor: Colors.indigo,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 12),
                                  ),
                                  onPressed: () {
                                    // Buy things
                                    state.isMembershipRequest
                                        ? context
                                            .read<PaymentCubit>()
                                            .getTheMembership()
                                        : context
                                            .read<PaymentCubit>()
                                            .bookTheEvent();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 14,
                                    ),
                                    child: Text('Proceed',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _upperTicketView(PaymentState state) {
    return state.isMembershipRequest
        ? state.paymentModel?.membershipType == MembershipType.GOLD
            ? _buildMembershipView(
                context: context,
                title: "Gold Membership",
                logoPath: "lib/assets/icons/profile/gold_card_glint_logo.svg",
                leftFeatures: [
                  '5 Superlikes',
                  '3 SuperDM',
                  '3 Rewinds',
                  'Unlimited Likes',
                  'See Who Likes You',
                ],
                rightFeatures: [
                  '7 AI Chat Suggestion',
                  'Hide Ads',
                  'Message First',
                ],
                price: state.totalAmount ?? "",
              )
            : _buildMembershipView(
                context: context,
                title: "Platinum Membership",
                logoPath:
                    "lib/assets/icons/profile/platinum_card_glint_logo.svg",
                leftFeatures: [
                  '8 Superlikes',
                  '7 SuperDM',
                  '7 Rewinds',
                  'Unlimited Likes',
                  'See Who Likes You',
                ],
                rightFeatures: [
                  'Profile Boost',
                  '15 AI Chat Suggestion',
                  'Message First',
                  'Hide Ads',
                ],
                price: state.totalAmount ?? "",
              )
        : _buildTicketView(state);
  }

  Widget _buildTicketView(PaymentState state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipPath(
        clipper: WaveClipper(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Event Ticket Booking',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Ticket Holders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTicketHolder(
                state.paymentModel?.userOne?.username ?? "You",
                state.paymentModel?.userOne?.imageUrl ?? "",
              ),
              _buildTicketHolder(
                state.paymentModel?.userTwo?.username ?? "Your Partner",
                state.paymentModel?.userTwo?.imageUrl ?? "",
              ),
              const Divider(),
              _buildPriceDetails(state.totalAmount ?? "10"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembershipView({
    required BuildContext context,
    required String title,
    required String logoPath,
    required List<String> leftFeatures,
    required List<String> rightFeatures,
    required String price,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTheme.headingFour.copyWith(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: AppColours.black,
                ),
              ),
              SvgPicture.asset(logoPath),
            ],
          ),

          // Features section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: leftFeatures
                      .map(
                        (feature) => _buildTickLabel(feature, isSmallScreen),
                      )
                      .toList(),
                ),
              ),
              // Right column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rightFeatures
                      .map(
                        (feature) => _buildTickLabel(
                          feature,
                          isSmallScreen,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTicketHolder(String name, String imagePath) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(imagePath)),
      title: Text(name),
      trailing: const Icon(Icons.check_circle, color: Colors.indigo),
    );
  }

  Widget _buildPriceDetails(
    String totalAmount,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceRow(
              // 'Ticket cost per person', '₹ ${int.parse(totalAmount) / 2}'),
              'Ticket cost per person',
              '₹ $totalAmount'),
          _buildPriceRow('Person(s)', 'x 2'),
          _buildPriceRow('Ticket Amount', '₹ $totalAmount'),
          _buildPriceRow('GST', '+ 18%'),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse successResponse) {
    print("Success Payment callback called $successResponse");
    if (context.mounted) {
      if (successResponse.data != null) {
        if (successResponse.orderId != null &&
            successResponse.paymentId != null &&
            successResponse.signature != null) {
          context.read<PaymentCubit>().verifyThePayment(
                successResponse.paymentId!,
                successResponse.orderId!,
                successResponse.signature!,
              );
        }
      }
    } else {
      print("Context changes, can't find payment");
    }
  }

  void _handlePaymentFailure(PaymentFailureResponse failureResponse) {
    print(
        "PaymentFailed : Response : ${failureResponse.error}, ${failureResponse.message}");
  }

  void _handlePaymentWalletAdded(ExternalWalletResponse walletAddedResponse) {}
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 10);
    double waveWidth = size.width / 10;
    double waveHeight = 5; // Reduced wave height for a more subtle effect

    for (double i = 0; i < size.width; i += waveWidth) {
      path.quadraticBezierTo(i + waveWidth / 4, size.height - 10 + waveHeight,
          i + waveWidth / 2, size.height - 10);
      path.quadraticBezierTo(i + 3 * waveWidth / 4,
          size.height - 10 - waveHeight, i + waveWidth, size.height - 10);
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// feature tick label
Widget _buildTickLabel(String text, bool isSmallScreen) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.check,
        color: AppColours.white,
        size: isSmallScreen ? 16.0 : 18.0,
      ),
      const Gap(4.0),
      Expanded(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: AppColours.black,
            fontSize: isSmallScreen ? 12.0 : 14.0,
          ),
        ),
      ),
    ],
  );
}
