import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class ToggleOption extends StatefulWidget {
  final String label;
  final List<String> toggleValues; // Add toggleValues parameter
  final String? initialValue; // Add initialValue parameter
  final ValueChanged<String?>? onChanged; // Add onChanged callback

  const ToggleOption({
    super.key,
    required this.label,
    required this.toggleValues, // Require toggleValues
    this.initialValue, // Accept initialValue
    this.onChanged, // Accept onChanged callback
  });

  @override
  State<ToggleOption> createState() => _ToggleOptionState();
}

class _ToggleOptionState extends State<ToggleOption> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialValue; // Initialize with initialValue
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.label,
            style: labelStyle,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _selectedOption == widget.toggleValues.first
                  ? toggleOptionSelectedLengkapColor // Assuming first value uses Lengkap color
                  : _selectedOption == widget.toggleValues.last
                      ? toggleOptionSelectedTidakColor // Assuming last value uses Tidak color
                      : borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.toggleValues.length, (index) {
              final value = widget.toggleValues[index];
              final isSelected = _selectedOption == value;
              final isFirst = index == 0;
              final isLast = index == widget.toggleValues.length - 1;

              Color optionColor = Colors.white;
              if (isSelected) {
                if (isFirst) {
                  optionColor = toggleOptionSelectedLengkapColor;
                } else if (isLast) {
                  optionColor = toggleOptionSelectedTidakColor;
                }
                // Add more conditions here if there are more than two toggle values with different colors
              }

              Color borderColorForSide = borderColor;
               if (_selectedOption == widget.toggleValues.first) {
                borderColorForSide = toggleOptionSelectedLengkapColor;
              } else if (_selectedOption == widget.toggleValues.last) {
                borderColorForSide = toggleOptionSelectedTidakColor;
              }


              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedOption == value) {
                        _selectedOption = null;
                      } else {
                        _selectedOption = value;
                      }
                    });
                    widget.onChanged?.call(_selectedOption); // Call onChanged
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: optionColor,
                      borderRadius: BorderRadius.only(
                        topLeft: isFirst ? const Radius.circular(6.0) : Radius.zero,
                        bottomLeft: isFirst ? const Radius.circular(6.0) : Radius.zero,
                        topRight: isLast ? const Radius.circular(6.0) : Radius.zero,
                        bottomRight: isLast ? const Radius.circular(6.0) : Radius.zero,
                      ),
                      border: Border(
                        right: isLast ? BorderSide.none : BorderSide(
                          color: borderColorForSide,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        value,
                        style: isSelected
                            ? toggleOptionTextStyle.copyWith(color: Colors.white)
                            : hintTextStyle,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
