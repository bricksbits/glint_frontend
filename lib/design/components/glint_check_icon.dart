import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class GlintCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const GlintCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<GlintCheckBox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<GlintCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: widget.value ? AppColours.primaryBlue : Colors.white,
          border: Border.all(
            color: widget.value ? AppColours.primaryBlue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: widget.value
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }
}
