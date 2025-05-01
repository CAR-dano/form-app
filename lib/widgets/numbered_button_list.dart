import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class NumberedButtonList extends StatefulWidget {
  final String label;
  final int count;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const NumberedButtonList({
    Key? key,
    required this.label,
    required this.count,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _NumberedButtonListState createState() => _NumberedButtonListState();
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
        SizedBox(
          height: 35,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.count,
            itemBuilder: (context, index) {
              final itemNumber = index + 1;
              final isSelected = index == widget.selectedIndex;
              return GestureDetector(
                onTap: () => widget.onItemSelected(index),
                child: Container(
                  width: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isSelected ? toggleOptionSelectedLengkapColor : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: toggleOptionSelectedLengkapColor,
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
            },
          ),
        ),
      ],
    );
  }
}
