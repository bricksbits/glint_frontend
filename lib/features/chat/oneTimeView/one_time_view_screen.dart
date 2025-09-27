import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class OneTimeViewScreen extends StatelessWidget {
  final String? imageUrl;

  const OneTimeViewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColours.white,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'lib/assets/icons/glint_logo.svg',
              ),
              const Gap(10),
              const Text("One Time PhotoView")
            ],
          ),
        ),
      ),
      body: imageUrl != null
          ? Image.network(
              imageUrl!,
              fit: BoxFit.fill,
              width: query.width,
              height: query.height,
              // loadingBuilder: (context, child, loadingProgress) {
              //   return loadingProgress.cumulativeBytesLoaded <= 100 ? const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // },
              errorBuilder: (context, error, stackTraces) {
                return const Center(
                  child: Text("Check your internet once, please,"),
                );
              },
            )
          : const Center(
              child:
                  Text("Invalid Images, tell the sender\nto send it you again"),
            ),
    );
  }
}
