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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between buttons
          children: List.generate(widget.count, (value) {
            final itemNumber = value + 1;
            final isSelected = itemNumber == widget.selectedValue;
            // REMOVE Expanded
            return GestureDetector( // GestureDetector is now the direct child of Row's list
              onTap: () => widget.onItemSelected(value + 1),
              child: Container(
                height: 35,
                width: 35, // This width will now be respected
                // Add margin if spaceAround/spaceBetween is not enough, or if you use MainAxisAlignment.start
                // margin: const EdgeInsets.symmetric(horizontal: 4.0), // Example margin
                decoration: BoxDecoration(
                  color: isSelected ? numberedButtonColors[itemNumber] : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
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
        ),
      ],
    );
  }
}
