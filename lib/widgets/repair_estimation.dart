import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/formatters/thousands_separator_input_formatter.dart'; // Import thousands separator formatter

class RepairEstimation extends StatefulWidget {
  const RepairEstimation({
    super.key,
    required this.label,
    required this.initialEstimations,
    required this.onChanged,
  });

  final String label;
  final List<Map<String, String>> initialEstimations;
  final ValueChanged<List<Map<String, String>>> onChanged;

  @override
  State<RepairEstimation> createState() => _RepairEstimationState();
}

class _RepairEstimationState extends State<RepairEstimation> {
  final List<Map<String, String>> _estimations = [];
  final List<TextEditingController> _repairControllers = [];
  final List<TextEditingController> _priceControllers = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialEstimations.isNotEmpty) {
      for (var estimation in widget.initialEstimations) {
        _addEstimation(estimation['repair'] ?? '', estimation['price'] ?? '');
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _repairControllers) {
      controller.dispose();
    }
    for (var controller in _priceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addEstimation([String repair = '', String price = '']) {
    setState(() {
      _estimations.add({'repair': repair, 'price': price});
      _repairControllers.add(TextEditingController(text: repair));
      _priceControllers.add(TextEditingController(text: price));
      _attachListeners(_estimations.length - 1);
    });
  }

  void _removeEstimation(int index) {
    setState(() {
      _estimations.removeAt(index);
      _repairControllers[index].dispose();
      _priceControllers[index].dispose();
      _repairControllers.removeAt(index);
      _priceControllers.removeAt(index);
      _notifyParent();
    });
  }

  void _updateEstimation(int index) {
    _estimations[index]['repair'] = _repairControllers[index].text;
    _estimations[index]['price'] = _priceControllers[index].text;
    _notifyParent();
  }

  void _attachListeners(int index) {
    _repairControllers[index].addListener(() => _updateEstimation(index));
    _priceControllers[index].addListener(() => _updateEstimation(index));
  }

  void _notifyParent() {
    widget.onChanged(_estimations);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: labelStyle, // Use labelStyle from app_styles.dart
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _estimations.length,
          itemBuilder: (context, index) {
            final bool repairHasText = _repairControllers[index].text.isNotEmpty;
            final bool priceHasText = _priceControllers[index].text.isNotEmpty;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container( // Wrap with Container for border
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor, // Use borderColor from app_styles.dart
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container( // Wrap TextField in Container for border
                        decoration: BoxDecoration(
                           border: Border(
                            right: BorderSide(
                              color: borderColor, // Use borderColor for vertical separator
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: _repairControllers[index],
                          style: repairHasText ? toggleOptionTextStyle.copyWith(color: Colors.white) : hintTextStyle, // Use toggleOptionTextStyle when text is present, hintTextStyle otherwise
                          decoration: InputDecoration(
                            hintText: 'Masukkan perbaikan',
                            hintStyle: hintTextStyle, // Use hintTextStyle
                            filled: repairHasText, // Fill only if text is present
                            fillColor: borderColor, // Use borderColor for background when filled
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), bottomLeft: Radius.circular(6.0)), // Apply border radius to left side
                            borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0), // Adjusted vertical padding
                            isDense: true, // Make the input decorator more compact
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container( // Wrap TextField and IconButton in Container for border
                        decoration: BoxDecoration(
                           border: Border(
                            // Removed left border to avoid double border
                          ),
                        ),
                        child: Row( // Inner Row for price TextField and IconButton
                          children: [
                            Expanded( // Expanded for price TextField
                              child: TextField(
                                controller: _priceControllers[index],
                                keyboardType: TextInputType.number, // Set keyboard type to number
                                style: priceHasText ? priceTextStyle : hintTextStyle, // Use priceTextStyle when text is present, hintTextStyle otherwise
                                inputFormatters: [
                                  ThousandsSeparatorInputFormatter()
                                ], // Apply thousands separator formatter
                                decoration: InputDecoration(
                                  hintText: 'Masukkan harga',
                                  hintStyle: hintTextStyle, // Use hintTextStyle
                                  filled: false, // Do not fill based on text
                                  fillColor: Colors.transparent, // Keep background transparent
                                  border: OutlineInputBorder(
                                     borderRadius: BorderRadius.only(topRight: Radius.circular(6.0), bottomRight: Radius.circular(6.0)), // Apply border radius to right side
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0), // Adjusted vertical padding
                                  isDense: true, // Make the input decorator more compact
                                ),
                              ),
                            ),
                            SizedBox( // Wrap IconButton in SizedBox for fixed width
                              width: 48.0, // Approximate width of an IconButton
                              child: IconButton(
                                icon: const Icon(Icons.close_outlined, size: 14.0), // Set icon size to 14.0
                                onPressed: () {
                                  _removeEstimation(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        TextButton.icon(
          onPressed: _addEstimation,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Tambah List'),
        ),
      ],
    );
  }
}
