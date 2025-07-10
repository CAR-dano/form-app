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
      FocusScope.of(context).unfocus(); // Unfocus the text fields
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
      mainAxisSize: MainAxisSize.min, 
      children: [
        Text(
          widget.label,
          style: labelStyle, // Use labelStyle from app_styles.dart
        ),
        const SizedBox(height: 8.0),
        for (int index = 0; index < _estimations.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: borderColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: _repairControllers[index],
                        textCapitalization: TextCapitalization.sentences,
                        style: _repairControllers[index].text.isNotEmpty
                            ? toggleOptionTextStyle.copyWith(color: Colors.white)
                            : hintTextStyle,
                        decoration: InputDecoration(
                          hintText: 'Barang',
                          hintStyle: hintTextStyle,
                          filled: _repairControllers[index].text.isNotEmpty,
                          fillColor: borderColor,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                bottomLeft: Radius.circular(6.0)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _priceControllers[index],
                            keyboardType: TextInputType.number,
                            style: _priceControllers[index].text.isNotEmpty
                                ? priceTextStyle
                                : hintTextStyle,
                            inputFormatters: [ThousandsSeparatorInputFormatter()],
                            decoration: InputDecoration(
                              hintText: 'Biaya',
                              hintStyle: hintTextStyle,
                              filled: false,
                              fillColor: Colors.transparent,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6.0),
                                    bottomRight: Radius.circular(6.0)),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 12.0),
                              isDense: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 48.0,
                          child: IconButton(
                            icon: const Icon(Icons.close_outlined, size: 14.0),
                            onPressed: () {
                              _removeEstimation(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        TextButton.icon(
          onPressed: _addEstimation,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Tambah List'),
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(selectedDateColor),
            overlayColor: WidgetStateProperty.all<Color>(borderColor.withAlpha(15)), 
          ),
        ),
      ],
    );
  }
}
