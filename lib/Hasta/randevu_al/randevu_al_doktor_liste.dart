import 'package:flutter/material.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';
import '../ana_ekran/anaekranfonk.dart';

class FilteredDoctorsScreen extends StatelessWidget {
  final List<Doctors> filteredDoctors;

  const FilteredDoctorsScreen({
    super.key,
    required this.filteredDoctors,
  });

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filtrelenen Doktorlar',
          style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: acikKirmizi,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
           // Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(ekranGenisligi * 0.05),
        child: filteredDoctors.isNotEmpty
            ? ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return DoctorCard(
                    name: doctor.name ?? "",
                    specialization: doctor.branch ?? "",
                    rating: doctor.reviews?.isNotEmpty == true
                        ? doctor.reviews![0].points.toString()
                        : "0",
                    reviews: doctor.reviews?.length.toString() ?? "0",
                    favourite: true,
                  );
                },
                prototypeItem: SizedBox(height: ekranYuksekligi * 0.1),
              )
            : Center(
                child: Text(
                  "Seçilen filtrelere uygun doktor bulunamadı!",
                  style: TextStyle(
                    fontSize: ekranGenisligi / 22,
                    fontFamily: "ABeeZee",
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
