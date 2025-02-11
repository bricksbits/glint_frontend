import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class NumberOfPersonSelector extends StatefulWidget {
  final int initialValue;
  final int? minValue;
  final int? maxValue;
  final void Function(int)? onChanged;

  const NumberOfPersonSelector({
    super.key,
    this.initialValue = 1,
    this.minValue,
    this.maxValue,
    this.onChanged,
  });

  @override
  State createState() => _NumberOfPersonSelectorState();
}

class _NumberOfPersonSelectorState extends State<NumberOfPersonSelector> {
  late TextEditingController _controller;
  late int _currentValue;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = TextEditingController(text: _currentValue.toString());
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateValue(int? newValue) {
    if (newValue == null) return;

    int value = newValue;
    if (widget.minValue != null) {
      value = value.clamp(widget.minValue!, widget.maxValue ?? value);
    }
    if (widget.maxValue != null) {
      value = value.clamp(widget.minValue ?? value, widget.maxValue!);
    }

    setState(() {
      _currentValue = value;
      _controller.text = value.toString();
      widget.onChanged?.call(value);
    });
  }

  void _increment() {
    _updateValue(_currentValue + 1);
  }

  void _decrement() {
    if (_currentValue > 1) {
      _updateValue(_currentValue - 1);
    }
  }

  void _handleSubmitted(String text) {
    final newValue = int.tryParse(text);
    if (newValue != null) {
      _updateValue(newValue);
    } else {
      _controller.text = _currentValue.toString();
    }
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Minus Button
        GestureDetector(
          onTap: _decrement,
          child: Container(
            height: 44.0,
            width: 68.0,
            decoration: BoxDecoration(
              color: AppColours.lightPink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.remove),
          ),
        ),

        const Gap(20.0),

        // Number Input
        Expanded(
          child: Container(
            height: 44.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              ),
              style: AppTheme.simpleText,
              onSubmitted: _handleSubmitted,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  final newValue = int.tryParse(value);
                  if (newValue != null) {
                    _currentValue = newValue;
                    widget.onChanged?.call(newValue);
                  }
                }
              },
            ),
          ),
        ),

        const Gap(20.0),

        // Plus Button
        GestureDetector(
          onTap: _increment,
          child: Container(
            height: 44.0,
            width: 68.0,
            decoration: BoxDecoration(
              color: AppColours.backgroundShade,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
