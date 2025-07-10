import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const LabeledText({
    super.key,
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: valueStyle ?? selectedDateTextStyle.copyWith(color: selectedDateColor), // Use inputTextStyling as default
            ),
          ),
        ),
      ],
    );
  }
}
