import 'package:flutter/material.dart';
import 'package:glint_frontend/domain/business_logic/models/profile/profile_properties_enum.dart';

class CommonBottomSheetChipComponent<T extends Enum> extends StatefulWidget {
  final String title;
  final IconData icon;
  final T selectedValue;
  final List<T> listValues;
  final Function(T) onSelection;

  const CommonBottomSheetChipComponent({
    super.key,
    required this.title,
    required this.icon,
    required this.selectedValue,
    required this.listValues,
    required this.onSelection,
  });

  @override
  State<CommonBottomSheetChipComponent<T>> createState() =>
      _CommonBottomSheetChipComponentState<T>();
}

class _CommonBottomSheetChipComponentState<T extends Enum>
    extends State<CommonBottomSheetChipComponent<T>> {
  late T _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedValue;
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

          // Chips Grid using Wrap
          Wrap(
            spacing: 8.0, // Space between chips
            runSpacing: 8.0, // Space between rows
            children: widget.listValues.map((option) {
              final isSelected = option == _selected;
              return ChoiceChip(
                // Use the extension method for Title Case display
                label: Text(
                  option.toDisplayString(),
                ),
                selected: isSelected,
                selectedColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.15),
                labelStyle: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade300,
                  ),
                ),
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selected = option;
                      // Call the callback function immediately with the generic enum value
                      widget.onSelection(_selected);
                      // You could also close the sheet here if single selection completes the task
                      // Navigator.pop(context);
                    });
                  }
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          // Skip Button (bottom-aligned)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: const Text('Done', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
