import 'package:flutter/material.dart';

class IdentitasPage extends StatefulWidget {
  const IdentitasPage({super.key});

  @override
  State<IdentitasPage> createState() => _IdentitasPageState();
}

class _IdentitasPageState extends State<IdentitasPage> {
  final _inspectorController = TextEditingController();
  final _customerController = TextEditingController();
  final _branchController = TextEditingController();
  DateTime? _selectedDate;

   InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFC28CFF), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFC28CFF), width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  void dispose() {
    _inspectorController.dispose();
    _customerController.dispose();
    _branchController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Your background is dark
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page progress
                  Text(
                    '1/9',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Title
                  Text(
                    'Identitas',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Nama Inspektor
                  Text('Nama Inspektor', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  TextField(
                    controller: _inspectorController,
                    decoration: _inputDecoration('Masukkan nama inspektor'),
                  ),
                  SizedBox(height: 16),

                  // Nama Customer
                  Text('Nama Costumer', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  TextField(
                    controller: _customerController,
                    decoration: _inputDecoration('Masukkan nama pelanggan'),
                  ),
                  SizedBox(height: 16),

                  // Cabang Inspeksi
                  Text('Cabang Inspeksi', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  TextField(
                    controller: _branchController,
                    decoration: _inputDecoration('Contoh : Yogyakarta / Semarang'),
                  ),
                  SizedBox(height: 16),

                  // Tanggal Inspeksi
                  Text('Tanggal Inspeksi', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: _inputDecoration(
                          _selectedDate == null
                              ? 'Pilih tanggal'
                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        ).copyWith(
                          suffixIcon: Icon(Icons.arrow_drop_down, color: Color(0xFFC28CFF)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle back
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 6,
                        ),
                        child: Text('Back', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Handle next
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 6,
                        ),
                        child: Text('Next', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Footer
                  Center(
                    child: Text(
                      'copyright by Inspeksi Mobil Jogja',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
