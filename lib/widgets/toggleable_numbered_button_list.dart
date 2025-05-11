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
  late int _persistedSelection;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.initialEnabled;
    _persistedSelection = widget.selectedValue;
    if (!_isEnabled && widget.selectedValue != widget.valueWhenDisabled) {
      // _persistedSelection holds the parent's initial value if widget starts disabled.
    }
  }

  @override
  void didUpdateWidget(ToggleableNumberedButtonList oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needsSetState = false;
    
    if (widget.selectedValue != oldWidget.selectedValue) {
      if (_isEnabled) {
        if (_persistedSelection != widget.selectedValue) {
          _persistedSelection = widget.selectedValue;
          needsSetState = true; 
        }
      } else { 
        if (widget.selectedValue != widget.valueWhenDisabled) {
          _persistedSelection = widget.selectedValue;
        }
      }
    }

    if (needsSetState) {
      setState(() {});
    }
  }

  void _handleCheckboxChange(bool? newValue) {
    final bool newEnabledState = newValue ?? false;
    if (_isEnabled != newEnabledState) {
      setState(() {
        _isEnabled = newEnabledState;
      });
      widget.onEnabledChanged(_isEnabled);

      if (!_isEnabled) { 
        widget.onItemSelected(widget.valueWhenDisabled);
      } else { 
        widget.onItemSelected(_persistedSelection);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color currentLabelColor = _isEnabled ? labelTextColor : Colors.grey.shade400;
    final Color effectiveBorderColor;
    if (!_isEnabled) {
      effectiveBorderColor = Colors.grey.shade300;
    } else if (_persistedSelection > 0 && numberedButtonColors.containsKey(_persistedSelection)) {
      effectiveBorderColor = numberedButtonColors[_persistedSelection]!;
    } else {
      effectiveBorderColor = toggleOptionSelectedLengkapColor; 
    }
    final Color currentButtonTextColor = _isEnabled ? Colors.black : Colors.grey.shade400;

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
                          value: _isEnabled,
                          onChanged: _handleCheckboxChange,
                          activeColor: toggleOptionSelectedLengkapColor,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            _handleCheckboxChange(!_isEnabled);
                          },
                          child: Text(
                            widget.label,
                            style: labelStyle.copyWith(color: currentLabelColor),
                            // overflow: TextOverflow.ellipsis, // Example
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
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
                final isSelected = _isEnabled && (itemNumber == _persistedSelection);

                final Color buttonBackgroundColor;
                if (isSelected) {
                  buttonBackgroundColor = numberedButtonColors[itemNumber]!;
                } else {
                  buttonBackgroundColor = Colors.white;
                }
                final Color buttonTextColor = isSelected ? Colors.white : currentButtonTextColor;

                return GestureDetector(
                  onTap: _isEnabled
                      ? () {
                          int newSelectionToPersist;
                          if (itemNumber == _persistedSelection) {
                            newSelectionToPersist = widget.valueWhenDisabled;
                          } else {
                            newSelectionToPersist = itemNumber;
                          }
                          
                          if (_persistedSelection != newSelectionToPersist) {
                            setState(() {
                              _persistedSelection = newSelectionToPersist;
                            });
                          }
                          widget.onItemSelected(newSelectionToPersist);
                        }
                      : null,
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
