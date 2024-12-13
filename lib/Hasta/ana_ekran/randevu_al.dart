import 'package:flutter/material.dart';
import '../../renkler/renkler.dart';

class RandevuAl extends StatefulWidget {
  const RandevuAl({super.key});

  @override
  State<RandevuAl> createState() => _RandevuAlState();
}

class _RandevuAlState extends State<RandevuAl> {
  String? selectedHospital;
  String? selectedBranch;
  DateTime? selectedDate;
  String? selectedTime;

  final List<String> hospitals = ["Hastane A", "Hastane B", "Hastane C"];
  final List<String> branches = ["Kardiyoloji", "Ortopedi", "Nöroloji"];
  final List<String> times = ["08:00", "10:00", "12:00"];

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _applyFilters() {
    Navigator.pushNamed(
      context,
      '/filteredDoctors', // Listeleme ekranının route adı
      arguments: {
        'hospital': selectedHospital,
        'branch': selectedBranch,
        'date': selectedDate,
        'time': selectedTime,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filtreleme Ekranı',
          style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
        ),
        backgroundColor: acikKirmizi,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hastane',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              hint: const Text("Hastane Seçin"),
              value: selectedHospital,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  selectedHospital = value;
                });
              },
              items: hospitals.map((hospital) {
                return DropdownMenuItem(
                  value: hospital,
                  child: Text(hospital),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Branş',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              hint: const Text("Branş Seçin"),
              value: selectedBranch,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  selectedBranch = value;
                });
              },
              items: branches.map((branch) {
                return DropdownMenuItem(
                  value: branch,
                  child: Text(branch),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tarih',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: _selectDate,
              style: ElevatedButton.styleFrom(
                backgroundColor: acikKirmizi,
                foregroundColor: beyaz,
              ),
              child: const Text("Tarih Seç"),
            ),
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Seçilen Tarih: ${selectedDate!.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            const SizedBox(height: 20),
            const Text(
              'Saat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              hint: const Text("Saat Seçin"),
              value: selectedTime,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  selectedTime = value;
                });
              },
              items: times.map((time) {
                return DropdownMenuItem(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: acikKirmizi,
                  foregroundColor: beyaz,
                ),
                child: const Text(
                  "Filtreleri Uygula",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
