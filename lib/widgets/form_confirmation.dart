import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class FormConfirmation extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final FontWeight? fontWeight;

  const FormConfirmation({
    super.key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
    this.fontWeight,
  });

  @override
  State<FormConfirmation> createState() => _CustomCheckboxTileState();
}

class _CustomCheckboxTileState extends State<FormConfirmation> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onChanged(_isChecked);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                side: const BorderSide(
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
          Expanded(
            child: Text(
              widget.label,
              style: labelStyle.copyWith(fontWeight: widget.fontWeight ?? FontWeight.w500),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
