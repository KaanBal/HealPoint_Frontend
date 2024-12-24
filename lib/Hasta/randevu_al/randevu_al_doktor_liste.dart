import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import '../../models/filterValues.dart';

class FilteredDoctorsScreen extends StatefulWidget {
  final FilterValues filterValues;

  const FilteredDoctorsScreen({
    Key? key,
    required this.filterValues,
  }) : super(key: key);

  @override
  State<FilteredDoctorsScreen> createState() => _FilteredDoctorsScreenState();
}

class _FilteredDoctorsScreenState extends State<FilteredDoctorsScreen> {
  List<Doctors> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _fetchFilteredDoctors(); // Fetch doctors based on filterCriteria
  }

  Future<void> _fetchFilteredDoctors() async {
    // Simulate backend request or local filtering
    await Future.delayed(const Duration(seconds: 1)); // Mock delay

    // Add logic to fetch doctors based on widget.filterCriteria
    // For now, we'll use a mock list
    setState(() {
      filteredDoctors = [
        Doctors(name: "Dr. Ahmet", branch: "Kardiyoloji"),
        Doctors(name: "Dr. Mehmet", branch: "Ortopedi"),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtrelenen Doktorlar"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filtreler:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Şehir: ${widget.filterValues.city ?? 'Seçilmedi'}"),
            Text("İlçe: ${widget.filterValues.district ?? 'Seçilmedi'}"),
            Text("Branş: ${widget.filterValues.branch ?? 'Seçilmedi'}"),
            Text(
              "Tarih: ${widget.filterValues.date != null ? DateFormat('dd MMMM yyyy').format(widget.filterValues.date!) : 'Seçilmedi'}",
            ),
            Text("Saat: ${widget.filterValues.time ?? 'Seçilmedi'}"),
            const SizedBox(height: 20),
            const Text(
              "Doktorlar:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            filteredDoctors.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = filteredDoctors[index];
                        return Card(
                          child: ListTile(
                            title: Text(doctor.name ?? "Doktor İsmi Yok"),
                            subtitle: Text(doctor.branch ?? "Branş Yok"),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
