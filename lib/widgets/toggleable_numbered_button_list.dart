// lib/widgets/toggleable_numbered_button_list.dart
import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class ToggleableNumberedButtonList extends StatefulWidget {
  final String label;
  final int count;
  final int selectedValue; // Represents 1-based number (1-10) or <= 0 if none/disabled
  final ValueChanged<int> onItemSelected; // Passes 1-based number or <= 0
  final bool initialEnabled;
  final ValueChanged<bool> onEnabledChanged;
  final int valueWhenDisabled;

  const ToggleableNumberedButtonList({
    super.key,
    required this.label,
    required this.count,
    required this.selectedValue,
    required this.onItemSelected,
    this.initialEnabled = true,
    required this.onEnabledChanged,
    this.valueWhenDisabled = 0,
  });

  @override
  State<ToggleableNumberedButtonList> createState() => _ToggleableNumberedButtonListState();
}

class _ToggleableNumberedButtonListState extends State<ToggleableNumberedButtonList> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.initialEnabled;
  }

  void _handleCheckboxChange(bool? newValue) {
    final bool newEnabledState = newValue ?? false;
    if (_isEnabled != newEnabledState) {
      setState(() {
        _isEnabled = newEnabledState;
      });
      widget.onEnabledChanged(_isEnabled);
      if (!_isEnabled) {
        widget.onItemSelected(widget.valueWhenDisabled); // Use the valueWhenDisabled property
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color currentLabelColor = _isEnabled ? labelTextColor : Colors.grey.shade400;
    final Color effectiveBorderColor;
    if (!_isEnabled) {
      effectiveBorderColor = Colors.grey.shade300;
    } else if (widget.selectedValue > 0 && numberedButtonColors.containsKey(widget.selectedValue)) {
      effectiveBorderColor = numberedButtonColors[widget.selectedValue]!;
    } else {
      effectiveBorderColor = toggleOptionSelectedLengkapColor;
    }
    final Color currentButtonTextColor = _isEnabled ? Colors.black : Colors.grey.shade400;

    // Use the same fixed size as NumberedButtonList
    const double buttonSize = 35.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Row for Checkbox and Label ---
        Row(
          children: [
            GestureDetector(
              onTap: () {
                _handleCheckboxChange(!_isEnabled);
              },
              child: Row( // Wrap checkbox, sizedbox, and text in a new Row for GestureDetector
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: Checkbox(
                        value: _isEnabled,
                        onChanged: _handleCheckboxChange,
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
                  const SizedBox(width: 8),
                  Text(
                    widget.label,
                    style: labelStyle.copyWith(color: currentLabelColor),
                  ),
                ],
              ),
            ),
            const Spacer(),
             if (!_isEnabled)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: toggleOptionSelectedTidakColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Tidak ada',
                    style: disabledToggleTextStyle,
                  ),
                ),
          ],
        ),
        const SizedBox(height: 4.0),

        // --- Row for Numbered Buttons ---
        Row(
           // Use spaceAround like in NumberedButtonList
           mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(widget.count, (index) {
            final itemNumber = index + 1;
            final isSelected = _isEnabled && (itemNumber == widget.selectedValue);

            final Color buttonBackgroundColor;
             if (isSelected) {
               buttonBackgroundColor = numberedButtonColors[itemNumber]!;
             } else {
               buttonBackgroundColor = Colors.white;
             }
            final Color buttonTextColor = isSelected ? Colors.white : currentButtonTextColor;

            // --- Wrap with Expanded ---
            return Expanded(
              child: GestureDetector(
                onTap: _isEnabled
                  ? () => widget.onItemSelected(itemNumber == widget.selectedValue ? -1 : itemNumber)
                  : null,
                // --- Container INSIDE Expanded with fixed size ---
                child: Container(
                  height: buttonSize, // Fixed height
                  width: buttonSize,  // Fixed width (RE-ADDED)
                  // No margin needed here, Expanded + spaceAround handles spacing
                  decoration: BoxDecoration(
                    color: buttonBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: effectiveBorderColor,
                      width: 2, // Use 1.5 or 2 based on desired look
                    ),
                  ),
                  child: Center( // Center the text within the fixed-size container
                    child: Text(
                      itemNumber.toString(),
                      style: toggleOptionTextStyle.copyWith(
                        color: buttonTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
