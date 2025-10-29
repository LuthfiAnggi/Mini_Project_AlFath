// lib/presentation/widgets/filter_dialog_content.dart

import 'package:flutter/material.dart';


class FilterWidgetContent extends StatefulWidget {
  // Kita tetap gunakan callback ini untuk memberi tahu parent saat ditutup
  final VoidCallback onFilterApply;

  const FilterWidgetContent({
    super.key,
    required this.onFilterApply,
  });

  @override
  State<FilterWidgetContent> createState() => _FilterWidgetContentState();
}

class _FilterWidgetContentState extends State<FilterWidgetContent> {
  // State pilihan (biarkan sama)
  String _selectedTipe = 'Semua';
  String _gajiMin = 'Rp 0';
  String _gajiMax = 'Rp 10 jt';
  final List<String> _tipePekerjaan = ['Semua', 'Fulltime', 'Part-time', 'Internship'];
  final List<String> _opsiGaji = ['Rp 0', 'Rp 2 jt', 'Rp 5 jt', 'Rp 10 jt'];

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
              // ... (Kode ChoiceChip Anda tetap sama persis) ...
              return ChoiceChip(
                label: Text(tipe),
                selected: _selectedTipe == tipe,
                onSelected: (isSelected) {
                  if (isSelected) {
                    setState(() { _selectedTipe = tipe; });
                  }
                },
                selectedColor: Color(0xFFE0F7FA),
                backgroundColor: Colors.grey[100],
                labelStyle: TextStyle(
                  color: _selectedTipe == tipe ? Colors.blue[800] : Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: _selectedTipe == tipe ? Colors.blue : Colors.grey[300]!,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24.0),

          // --- GAJI MINIMAL & MAKSIMAL ---
          Row(
            children: [
              // --- GAJI MINIMAL ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gaji minimal',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8.0),
                    _buildGajiDropdown(
                      value: _gajiMin,
                      onChanged: (newValue) {
                        setState(() { _gajiMin = newValue!; });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              // --- GAJI MAKSIMAL ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gaji maksimal',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8.0),
                    _buildGajiDropdown(
                      value: _gajiMax,
                      onChanged: (newValue) {
                        setState(() { _gajiMax = newValue!; });
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
              // Panggil callback (yang akan menutup bottom sheet)
              widget.onFilterApply();
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: _opsiGaji.map((String gaji) {
            return DropdownMenuItem<String>(
              value: gaji,
              child: Text(gaji),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}