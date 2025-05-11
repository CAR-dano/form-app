import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class NumberedButtonList extends StatefulWidget {
  final String label;
  final int count;
  final int selectedValue;
  final ValueChanged<int> onItemSelected;

  const NumberedButtonList({
    super.key,
    required this.label,
    required this.count,
    required this.selectedValue,
    required this.onItemSelected,
  });

  @override
  State<NumberedButtonList> createState() => _NumberedButtonListState();
}

class _NumberedButtonListState extends State<NumberedButtonList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: labelStyle,
        ),
        const SizedBox(height: 4.0),
        LayoutBuilder(
          builder: (context, constraints) {
            double availableWidth = constraints.maxWidth;
            double preferredButtonWidth = 35.0;
            int numberOfButtons = widget.count;
            
            // Calculate width needed if all buttons are at preferred width and touch each other
            double totalPreferredWidthWithoutSpacing = numberOfButtons * preferredButtonWidth;
            double actualButtonWidth;

            if (availableWidth < totalPreferredWidthWithoutSpacing) {
              // Not enough space for all buttons at preferred width, so they must shrink.
              // They will take up all available space, divided equally.
              actualButtonWidth = availableWidth / numberOfButtons;
            } else {
              // Enough space. Buttons can be at their preferred width.
              // MainAxisAlignment.spaceBetween will handle distributing extra space if any.
              actualButtonWidth = preferredButtonWidth;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // This will correctly handle spacing in both scenarios
              children: List.generate(numberOfButtons, (value) {
                final itemNumber = value + 1;
                final isSelected = itemNumber == widget.selectedValue;
                
                return GestureDetector(
                  onTap: () => widget.onItemSelected(value + 1),
                  child: Container(
                    height: 35,
                    width: actualButtonWidth, // Apply the calculated width
                    decoration: BoxDecoration(
                      color: isSelected ? numberedButtonColors[itemNumber] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        // Preserving original border color logic, assuming numberedButtonColors and selectedValue are handled correctly
                        color: widget.selectedValue != -1 && widget.selectedValue <= numberedButtonColors.length 
                            ? numberedButtonColors[widget.selectedValue]!
                            : toggleOptionSelectedLengkapColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        itemNumber.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
