import 'package:flutter/material.dart';

class HeightInputComponent extends StatefulWidget {
  const HeightInputComponent({super.key});

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
    return Center(
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
