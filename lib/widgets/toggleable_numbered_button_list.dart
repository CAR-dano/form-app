import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class ToggleableNumberedButtonList extends StatefulWidget {
  final String label;
  final int count;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final bool initialEnabled;
  final ValueChanged<bool> onEnabledChanged;

  const ToggleableNumberedButtonList({
    super.key,
    required this.label,
    required this.count,
    required this.selectedIndex,
    required this.onItemSelected,
    this.initialEnabled = true,
    required this.onEnabledChanged,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: _isEnabled,
              onChanged: (bool? newValue) {
                setState(() {
                  _isEnabled = newValue ?? false;
                });
                widget.onEnabledChanged(_isEnabled);
              },
              activeColor: toggleOptionSelectedLengkapColor,
            ),
            Text(
              widget.label,
              style: labelStyle,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _isEnabled
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(widget.count, (index) {
                  final itemNumber = index + 1;
                  final isSelected = index == widget.selectedIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: _isEnabled ? () => widget.onItemSelected(index) : null,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: isSelected ? numberedButtonColors[itemNumber] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.selectedIndex != -1 && widget.selectedIndex + 1 <= numberedButtonColors.length
                                ? numberedButtonColors[widget.selectedIndex + 1]!
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
                    ),
                  );
                }),
              )
            : const Text(
                'Tidak Ada',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
      ],
    );
  }
}
