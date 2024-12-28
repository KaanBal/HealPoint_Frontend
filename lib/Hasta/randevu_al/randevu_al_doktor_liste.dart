import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/services/doctor_service.dart';
import '../../models/filterValues.dart';
import 'package:yazilim_projesi/Doctor/doktor_bilgi/doktor_bilgi.dart';

class FilteredDoctorsScreen extends StatefulWidget {
  final FilterValues filterValues;

  const FilteredDoctorsScreen({
    super.key,
    required this.filterValues,
  });

  @override
  State<FilteredDoctorsScreen> createState() => _FilteredDoctorsScreenState();
}

class _FilteredDoctorsScreenState extends State<FilteredDoctorsScreen> {
  List<Doctors> filteredDoctors = [];
  final doctorService = DoctorService();

  @override
  void initState() {
    super.initState();
    _fetchFilteredDoctors();
  }

  Future<void> _fetchFilteredDoctors() async {
    try {
      final response = await doctorService.filterDoctors(widget.filterValues);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          filteredDoctors =
              data.map((doctorJson) => Doctors.fromJson(doctorJson)).toList();
        });
      } else {
        print("Error: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Aradığınız Uygunlukta Doktor Bulunamadı")),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doktorlar Görüntülenemdi")),
      );
    }
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorBilgiEkran(doctorId: doctor.tc!),
                                ),
                              );
                            },
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
