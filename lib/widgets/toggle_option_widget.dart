import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class ToggleOption extends StatefulWidget {
  final String label;

  const ToggleOption({super.key, required this.label});

  @override
  State<ToggleOption> createState() => _ToggleOptionState();
}

class _ToggleOptionState extends State<ToggleOption> {
  String? _selectedOption; // 'Lengkap' or 'Tidak'

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.label,
            style: labelStyle,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _selectedOption == 'Lengkap'
                  ? toggleOptionSelectedLengkapColor
                  : _selectedOption == 'Tidak'
                      ? toggleOptionSelectedTidakColor
                      : borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedOption == 'Lengkap') {
                        _selectedOption = null;
                      } else {
                        _selectedOption = 'Lengkap';
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: _selectedOption == 'Lengkap'
                          ? toggleOptionSelectedLengkapColor
                          : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      border: Border(
                        right: BorderSide(
                          color: _selectedOption == 'Lengkap'
                              ? toggleOptionSelectedLengkapColor
                              : _selectedOption == 'Tidak'
                                  ? toggleOptionSelectedTidakColor
                                  : borderColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Lengkap',
                        style: _selectedOption == 'Lengkap'
                            ? toggleOptionTextStyle.copyWith(color: Colors.white)
                            : hintTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedOption == 'Tidak') {
                        _selectedOption = null;
                      } else {
                        _selectedOption = 'Tidak';
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: _selectedOption == 'Tidak'
                          ? toggleOptionSelectedTidakColor
                          : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6.0),
                        bottomRight: Radius.circular(6.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Tidak',
                        style: _selectedOption == 'Tidak'
                            ? toggleOptionTextStyle.copyWith(color: Colors.white)
                            : hintTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
