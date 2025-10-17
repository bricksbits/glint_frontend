import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/glint_text_input_field.dart';
import 'package:glint_frontend/domain/business_logic/models/profile/profile_properties_enum.dart';

class CommonBottomSheetComponent<T extends Enum> extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function(String) onValueAdded;
  final String? lastValue;

  const CommonBottomSheetComponent({
    super.key,
    required this.title,
    required this.icon,
    required this.onValueAdded,
    required this.lastValue,
  });

  @override
  State<CommonBottomSheetComponent<T>> createState() =>
      _CommonBottomSheetComponentState<T>();
}

class _CommonBottomSheetComponentState<T extends Enum>
    extends State<CommonBottomSheetComponent<T>> {
  final _bottomSheetTextController = TextEditingController();

  @override
  void initState() {
    _bottomSheetTextController.text = widget.lastValue ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding to account for the mobile navigation bar at the bottom
      padding: EdgeInsets.only(
        top: 24.0,
        left: 24.0,
        right: 24.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Header: Icon and Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon,
                  size: 30,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.7)),
              const SizedBox(width: 10),
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 30),

          SizedBox(
            width: double.infinity,
            child: GlintTextInputField(
              controller: _bottomSheetTextController,
              hintText: 'Ex: He/Him',
              suffix: GestureDetector(
                onTap: () {
                  widget.onValueAdded(_bottomSheetTextController.text.trim());
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: AppColours.primaryBlue,
                  size: 20.0,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Skip Button (bottom-aligned)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: const Text('Skip >>', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
