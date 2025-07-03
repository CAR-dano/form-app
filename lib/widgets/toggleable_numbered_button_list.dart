// lib/widgets/toggleable_numbered_button_list.dart
import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class ToggleableNumberedButtonList extends StatefulWidget {
  final String label;
  final int count;
  final int selectedValue;
  final ValueChanged<int> onItemSelected;
  final int valueWhenDisabled;

  const ToggleableNumberedButtonList({
    super.key,
    required this.label,
    required this.count,
    required this.selectedValue,
    required this.onItemSelected,
    this.valueWhenDisabled = 0,
  });

  @override
  State<ToggleableNumberedButtonList> createState() => _ToggleableNumberedButtonListState();
}

class _ToggleableNumberedButtonListState extends State<ToggleableNumberedButtonList> {
  late int _persistedSelection; // Remembers the last active selection (1-10)

  @override
  void initState() {
    super.initState();
    // Initialize _persistedSelection: if selectedValue is active, use it, else default to 1.
    _persistedSelection = (widget.selectedValue != widget.valueWhenDisabled)
        ? widget.selectedValue
        : 1; // Default to 1 if initially "off"
  }

  @override
  void didUpdateWidget(ToggleableNumberedButtonList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      // If parent changes selectedValue to an active one, update our memory.
      if (widget.selectedValue != widget.valueWhenDisabled) {
        _persistedSelection = widget.selectedValue;
      }
      // We need to rebuild if selectedValue changes as it drives the UI.
      setState(() {}); 
    }
  }

  void _handleCheckboxOrLabelClick() {
    final bool isCurrentlyEffectivelyOn = widget.selectedValue != widget.valueWhenDisabled;

    if (isCurrentlyEffectivelyOn) { // Currently ON, user wants to turn OFF
      // _persistedSelection already holds the value that was active.
      widget.onItemSelected(widget.valueWhenDisabled);
    } else { // Currently OFF, user wants to turn ON
      // Restore the remembered _persistedSelection.
      // If _persistedSelection somehow became valueWhenDisabled (e.g. initial state), default to 1.
      int valueToRestore = (_persistedSelection != widget.valueWhenDisabled) ? _persistedSelection : 1;
      widget.onItemSelected(valueToRestore);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEffectivelyEnabled = widget.selectedValue != widget.valueWhenDisabled;

    final Color currentLabelColor = isEffectivelyEnabled ? labelTextColor : Colors.grey.shade400;
    final Color currentButtonTextColor = isEffectivelyEnabled ? Colors.black : Colors.grey.shade400;
    
    final Color effectiveBorderColor;
    if (!isEffectivelyEnabled) {
      effectiveBorderColor = Colors.grey.shade300;
    } else {
      // If enabled, border color is based on the currently selected value (if any)
      effectiveBorderColor = numberedButtonColors.containsKey(widget.selectedValue)
          ? numberedButtonColors[widget.selectedValue]!
          : toggleOptionSelectedLengkapColor; // Default if no specific button is selected but enabled
    }

    const double buttonSize = 35.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: Checkbox(
                          value: isEffectivelyEnabled, // Driven by selectedValue
                          onChanged: (bool? newValue) { // newValue is the new state of the checkbox
                            _handleCheckboxOrLabelClick();
                          },
                          activeColor: toggleOptionSelectedLengkapColor,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: _handleCheckboxOrLabelClick,
                          child: Text(
                            widget.label,
                            style: labelStyle.copyWith(color: currentLabelColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
             if (!isEffectivelyEnabled) // Show "Tidak ada" if not effectively enabled
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
        LayoutBuilder(
          builder: (context, constraints) {
            double availableWidth = constraints.maxWidth;
            double preferredButtonWidth = buttonSize;
            int numberOfButtons = widget.count;

            double totalPreferredWidthWithoutSpacing = numberOfButtons * preferredButtonWidth;
            double actualButtonWidth;

            if (availableWidth < totalPreferredWidthWithoutSpacing) {
              actualButtonWidth = availableWidth / numberOfButtons;
            } else {
              actualButtonWidth = preferredButtonWidth;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(numberOfButtons, (index) {
                final itemNumber = index + 1;
                // A button is selected if the widget is effectively enabled AND its number matches selectedValue
                final bool isButtonSelected = isEffectivelyEnabled && (itemNumber == widget.selectedValue);

                final Color buttonBackgroundColor;
                if (isButtonSelected) {
                  buttonBackgroundColor = numberedButtonColors[itemNumber]!;
                } else {
                  buttonBackgroundColor = Colors.white;
                }
                final Color buttonTextColor = isButtonSelected ? Colors.white : currentButtonTextColor;

                return GestureDetector(
                  onTap: isEffectivelyEnabled // Buttons are only tappable if the whole widget is enabled
                      ? () {
                          if (itemNumber != widget.selectedValue) { // Tapping a new or different button
                            _persistedSelection = itemNumber; // Remember this new choice
                            widget.onItemSelected(itemNumber);
                          }
                          // If itemNumber == widget.selectedValue (tapping the currently selected button), do nothing.
                        }
                      : null, // Not tappable if not effectively enabled
                  child: Container(
                    height: buttonSize,
                    width: actualButtonWidth, // Apply the calculated width
                    decoration: BoxDecoration(
                      color: buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: effectiveBorderColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        itemNumber.toString(),
                        style: toggleOptionTextStyle.copyWith(
                          color: buttonTextColor,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
