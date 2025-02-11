import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glint_frontend/design/exports.dart';

class PriceInputField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const PriceInputField({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width / 4.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: AppTheme.simpleText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ).copyWith(right: 12.0),
            child: Text(
              '₹ ',
              style: AppTheme.simpleText.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          suffixText: 'per person',
          suffixStyle: AppTheme.smallBodyText,
        ),
      ),
    );
  }
}
