import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class NumberedButtonList extends StatefulWidget {
  final String label;
  final int count;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const NumberedButtonList({
    super.key,
    required this.label,
    required this.count,
    required this.selectedIndex,
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
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute space around the buttons
          children: List.generate(widget.count, (index) {
            final itemNumber = index + 1;
            final isSelected = index == widget.selectedIndex;
            return Expanded( // Use Expanded to make buttons take equal space
              child: GestureDetector(
                onTap: () => widget.onItemSelected(index),
                child: Container(
                  height: 35, // Maintain height
                  width: 35, // Set a fixed width for the button
                  // No margin here, Expanded will handle spacing
                  decoration: BoxDecoration(
                    color: isSelected ? numberedButtonColors[itemNumber] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.selectedIndex != -1 && widget.selectedIndex + 1 <= numberedButtonColors.length
                          ? numberedButtonColors[widget.selectedIndex + 1]!
                          : toggleOptionSelectedLengkapColor, // Default color if no button is selected or index is out of bounds
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
              ),
            );
          }),
        ),
      ],
    );
  }
}
