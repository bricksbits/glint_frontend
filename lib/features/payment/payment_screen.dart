import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

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
    context.read<PaymentCubit>().state.when(initiate:
        (orderId, key, amount, razorpayKey, name, desc, razorPayModel) {
      if (razorPayModel != null) {
        _razorpay.open(razorPayModel.toJson());
      }
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWalletAdded);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
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
                          _buildTicketHolder('Shubham (You)',
                              'lib/assets/images/temp_place_holder.png'),
                          _buildTicketHolder('Gajgamini',
                              'lib/assets/images/temp_place_holder.png'),
                          const Divider(),
                          _buildPriceDetails(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          children: [
                            Text('Amount to be paid',
                                style: TextStyle(color: Colors.grey)),
                            Text('₹ 470',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo)),
                            SizedBox(height: 10),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.indigo,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                          ),
                          onPressed: () {
                            // Buy things
                            context.read<PaymentCubit>().bookTheEvent("1", "1");
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 35),
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
    );
  }

  Widget _buildTicketHolder(String name, String imagePath) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(imagePath)),
      title: Text(name),
      trailing: const Icon(Icons.check_circle, color: Colors.indigo),
    );
  }

  Widget _buildPriceDetails() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceRow('Ticket cost per person', '₹ 199'),
          _buildPriceRow('Person(s)', 'x 2'),
          _buildPriceRow('Ticket Amount', '₹ 398'),
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
    print("Success Payment callback called");
    if (context.mounted) {
      if (successResponse.data != null) {
        if (successResponse.orderId != null &&
            successResponse.paymentId != null) {
          context.read<PaymentCubit>().verifyThePayment(
                successResponse.orderId!,
                successResponse.paymentId!,
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
