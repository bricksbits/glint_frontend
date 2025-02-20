import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TicketHolderView extends StatelessWidget {
  const TicketHolderView(
      {super.key, required this.person1Name, required this.person2Name, required this.totalAmount});

  final String person1Name;
  final String person2Name;
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Ticket Holders"), Text(totalAmount)],
          ),
          ListTile(
            leading: CircleAvatar(
                radius: 20,
                backgroundImage:
                    AssetImage("lib/assets/images/temp_place_holder.png")),
            title: Text(person1Name),
            trailing: const Icon(Icons.check_circle, color: Colors.indigo),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: CircleAvatar(
                radius: 20,
                backgroundImage:
                    AssetImage("lib/assets/images/temp_place_holder.png")),
            title: Text(person2Name),
            trailing: const Icon(Icons.check_circle, color: Colors.indigo),
          )
        ],
      ),
    );
  }
}
