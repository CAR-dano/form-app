import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class CustomCheckboxTile extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomCheckboxTile({
    super.key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CustomCheckboxTile> createState() => _CustomCheckboxTileState();
}

class _CustomCheckboxTileState extends State<CustomCheckboxTile> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          child: SizedBox(
            width: 18,
            height: 18,
            child: Checkbox(
              value: _isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked = newValue ?? false;
                });
                widget.onChanged(_isChecked);
              },
              activeColor: toggleOptionSelectedLengkapColor,
              materialTapTargetSize: MaterialTapTargetSize.padded, // Changed to padded
              visualDensity: VisualDensity.compact,
              side: BorderSide(
                color: toggleOptionSelectedLengkapColor,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          widget.label,
          style: labelStyle.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
