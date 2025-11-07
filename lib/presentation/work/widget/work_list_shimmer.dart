// lib/presentation/widgets/filter_dialog_content.dart

import 'package:flutter/material.dart';


typedef FilterCallback = void Function(Map<String, String> filters);

class FilterWidgetContent extends StatefulWidget {
  // Kita tetap gunakan callback ini untuk memberi tahu parent saat ditutup
  final FilterCallback onFilterApply;

  const FilterWidgetContent({
    super.key,
    required this.onFilterApply,
  });

  @override
  State<FilterWidgetContent> createState() => _FilterWidgetContentState();
}

class _FilterWidgetContentState extends State<FilterWidgetContent> {
 
  // 1. Ubah _tipePekerjaan menjadi List of Map
  final List<Map<String, String>> _tipePekerjaan = [
    {'label': 'Semua', 'value': 'Semua'},
    {'label': 'Fulltime', 'value': 'Fulltime'},
    {'label': 'Part-time', 'value': 'Partime'}, // <-- Perbaiki: Part-time -> Partime
    {'label': 'Kontrak', 'value': 'Kontrak'},
    {'label': 'Internship', 'value': 'Magang'}, // <-- Perbaiki: Internship -> Magang
  ];

  // Simpan 'value' yang dipilih
  String _selectedTipeValue = 'Semua';

  // 2. Ubah _opsiGaji menjadi List of Map
  final List<Map<String, String>> _opsiGaji = [
    {'label': 'Rp 0', 'value': '0'},
    {'label': 'Rp 2 jt', 'value': '2000000'},
    {'label': 'Rp 5 jt', 'value': '5000000'},
    {'label': 'Rp 10 jt', 'value': '10000000'},
  ];
  // Simpan 'value' yang dipilih
  String _gajiMinValue = '0';
  String _gajiMaxValue = '10000000'; // Contoh

  @override
  Widget build(BuildContext context) {
    // 1. TAMBAHKAN PADDING UNTUK BOTTOM SHEET
    return Padding(
      // Tambahkan padding di semua sisi + padding ekstra di bawah untuk safe area
      padding: EdgeInsets.fromLTRB(
        24.0,
        16.0, // Jarak di atas untuk handle
        24.0,
        24.0 + MediaQuery.of(context).viewPadding.bottom, // Jarak aman
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2. TAMBAHKAN DRAG HANDLE (OPSIONAL TAPI BAGUS)
          Center(
            child: Container(
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const SizedBox(height: 24.0), // Jarak dari handle ke judul

          // --- JUDUL TIPE PEKERJAAN ---
          const Text(
            'Tipe pekerjaan',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12.0),

          // --- CHIPS TIPE PEKERJAAN ---
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _tipePekerjaan.map((tipe) {
              final label = tipe['label']!;
              final value = tipe['value']!;
              final isSelected = _selectedTipeValue == value;

              return ChoiceChip(
                label: Text(label),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() { _selectedTipeValue = value; });
                  }
                },
                selectedColor: Color(0xFFE0F7FA),
                backgroundColor: Colors.grey[100],
                labelStyle: TextStyle(
                  color: isSelected == tipe ? Colors.blue[800] : Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: isSelected == tipe ? Colors.blue : Colors.grey[300]!,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24.0),

          // --- GAJI MINIMAL & MAKSIMAL ---
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Gaji minimal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8.0),
                    _buildGajiDropdown(
                      value: _gajiMinValue,
                      onChanged: (newValue) {
                        setState(() { _gajiMinValue = newValue!; });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Gaji maksimal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8.0),
                    _buildGajiDropdown(
                      // Anda bisa gunakan _opsiGaji yang sama atau yang berbeda
                      value: _gajiMaxValue,
                      onChanged: (newValue) {
                        setState(() { _gajiMaxValue = newValue!; });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32.0),

          // --- TOMBOL FILTER ---
          ElevatedButton(
            onPressed: () {
              // 3. KIRIM DATA YANG SUDAH BERSIH
              final filters = {
                'tipe': _selectedTipeValue,
                'minimalGaji': _gajiMinValue,
               'maksimalGaji': _gajiMaxValue, // (Jika API mendukung)
              };
              widget.onFilterApply(filters);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF34A8DB),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Filter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk dropdown (tetap sama)
  Widget _buildGajiDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      // ... (Style container Anda) ...
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: _opsiGaji.map((gaji) {
            return DropdownMenuItem<String>(
              value: gaji['value']!, // Kirim 'value' (angka)
              child: Text(gaji['label']!), // Tampilkan 'label' (Rp)
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}