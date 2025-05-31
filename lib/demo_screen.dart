import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/chat/event_ticket_view.dart';

import 'design/common/app_colours.dart';

//Todo : Delete once done?
class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: Center(
        child: EventTicketView(
          eventName:
              'https://s3-alpha-sig.figma.com/img/d546/c4ca/0dc3085e1152c4b71fb15bd95d600c2e?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HjVHs2IFdAC81gMZOgDbUoHESp3N~z8rLg3XEeHApUcqU84~T6ZIrFU4uMUvib4VFxD2uUCJYHhXia9ZBJBgTvu-YHM8W4pucDJ6dBiaKwUeK7yIbV~2fY0wIEPJ-5y7eviS~p2o0yZbDRawIH9zDL8J3dE-DqsZMugVnI62qs~KrOWxaCi4-sEQKr86G40ElHYZlxvR6FmbXc4bWTH-9ZTSi1VMogOm8XRfvPfa40YPTHxTGUDZXi2fNpku92XnRGfzHGX4K3g1RGcXShX7J6kli8HWwOZ0r-z2Ru0JL~d3LN185Q91LjlWxS5mN422HDsTtEiPChC~jwK1M5ALdA__',
          onDowloadTicket: () {},
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: CommonTicketBanner(
    //       bannerImagerUrl: '',
    //       onInfoClicked: () {},
    //       onClosedClicked: () {},
    //     ),
    //   ),
    // );
  }
}
