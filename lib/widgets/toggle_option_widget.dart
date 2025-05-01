import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class ToggleOptionWidget extends StatefulWidget {
  final String label;

  const ToggleOptionWidget({Key? key, required this.label}) : super(key: key);

  @override
  _ToggleOptionWidgetState createState() => _ToggleOptionWidgetState();
}

class _ToggleOptionWidgetState extends State<ToggleOptionWidget> {
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
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
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
                        style: toggleOptionTextStyle.copyWith(
                          color: _selectedOption == 'Lengkap'
                              ? Colors.white
                              : hintTextColor,
                        ),
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
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Tidak',
                        style: toggleOptionTextStyle.copyWith(
                          color: _selectedOption == 'Tidak'
                              ? Colors.white
                              : hintTextColor,
                        ),
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
