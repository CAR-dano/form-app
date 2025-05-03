import 'package:flutter/material.dart';

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
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
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
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _repairControllers[index],
                      style: TextStyle(
                        color: repairHasText ? Colors.white : Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Masukkan perbaikan',
                        filled: repairHasText,
                        fillColor: Colors.purple[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _priceControllers[index],
                      style: TextStyle(
                        color: priceHasText ? Colors.white : Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Masukkan harga',
                        filled: priceHasText,
                        fillColor: Colors.purple[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _removeEstimation(index);
                    },
                  ),
                ],
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
