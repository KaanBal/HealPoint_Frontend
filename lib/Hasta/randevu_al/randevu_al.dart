import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/Hasta/randevu_al/randevu_al_doktor_liste.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/models/filterValues.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class RandevuAl extends StatefulWidget {
  const RandevuAl({Key? key}) : super(key: key);

  @override
  State<RandevuAl> createState() => _RandevuAlState();
}

class _RandevuAlState extends State<RandevuAl> {
  final FilterValues filterValues = FilterValues();
  List<Doctors> doctors = [];
  final List<String> branches = ["Kardiyoloji", "Ortopedi", "Nöroloji"];
  final List<String> times = [
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00"
  ];

  Map<String, List<String>> cityDistrictMap = {};

  Future<void> _loadCityDistrictData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/sehir_ilce.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        cityDistrictMap = jsonData.map(
            (key, value) => MapEntry(key, List<String>.from(value as List)));
      });
    } catch (e) {
      debugPrint("Error loading JSON data: $e");
    }
  }

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (pickedDate != null) {
      setState(() {
        filterValues.date = pickedDate;
      });
    }
  }

  void _applyFilters() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredDoctorsScreen(
          filterValues: filterValues,
        ),
      ),
    );
  }

  @override
  void initState() {
    _loadCityDistrictData();
    super.initState();
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Şehir',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              hint: const Text("Şehir Seçin"),
              value: filterValues.city,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  filterValues.city = value;
                  filterValues.district = null;
                });
              },
              items: cityDistrictMap.keys.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            if (filterValues.city != null) ...[
              const SizedBox(height: 20),
              const Text(
                'İlçe',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                hint: const Text("İlçe Seçin"),
                value: filterValues.district,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    filterValues.district = value;
                  });
                },
                items: cityDistrictMap[filterValues.city]!.map((district) {
                  return DropdownMenuItem(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              'Branş',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              hint: const Text("Branş Seçin"),
              value: filterValues.branch,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  filterValues.branch = value;
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
            if (filterValues.date != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Seçilen Tarih: ${DateFormat('dd MMMM yyyy').format(filterValues.date!)}',
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
              value: filterValues.time,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  filterValues.time = value;
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
