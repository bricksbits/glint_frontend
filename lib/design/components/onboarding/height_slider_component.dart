import 'package:flutter/material.dart';

class HeightInputComponent extends StatefulWidget {
  const HeightInputComponent({super.key, required this.heightSelected});

  final Function(double) heightSelected;

  @override
  State<HeightInputComponent> createState() => _HeightInputComponentState();
}

class _HeightInputComponentState extends State<HeightInputComponent> {
  // 3 feet = 36 inches
  static const double minHeightInches = 36.0;

  // 8 feet = 96 inches
  static const double maxHeightInches = 96.0;

  // Default to 5'6"
  double _totalInches = 66.0;

  String _formatHeight(double totalInches) {
    final int inches = totalInches.round();
    final int feet = inches ~/ 12;
    final int remainingInches = inches % 12;
    return "$feet' $remainingInches";
  }

  double _getFinalValue() {
    return _totalInches.roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    int divisions = (maxHeightInches - minHeightInches).toInt();
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
              Icon(Icons.straighten,
                  size: 30,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.7)),
              const SizedBox(width: 10),
              const Text(
                "Height",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 30),

          Text(
            _formatHeight(_totalInches),
            style: TextStyle(
              fontSize: 58,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),

          Slider(
            value: _totalInches,
            min: minHeightInches,
            max: maxHeightInches,
            divisions: divisions,
            onChanged: (double newValue) {
              widget.heightSelected(newValue);
              setState(() {
                _totalInches = newValue;
              });
            },
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
    Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Height',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              _formatHeight(_totalInches),
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Slider(
              value: _totalInches,
              min: minHeightInches,
              max: maxHeightInches,
              divisions: divisions,
              onChanged: (double newValue) {
                widget.heightSelected(newValue);
                setState(() {
                  _totalInches = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
