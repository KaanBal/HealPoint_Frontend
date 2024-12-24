import 'package:flutter/material.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/Hasta/ana_ekran/anaekranfonk.dart';


class FavoriteDoctorsPage extends StatelessWidget {
  final double fontSize = 20.0;
  final double screenHeight = 800; // Ekran yüksekliğini dinamik yapmak için MediaQuery kullanılabilir.

  final List<Doctors> doctors = [
    Doctors(
      name: "Ahmet",
      branch: "Cardiology",
      tc: "12345",
    ),
    Doctors(
      name: "Zeynep",
      branch: "Dermatology",
      tc: "67890",
    ),
    Doctors(
      name: "Mehmet",
      branch: "Pediatrics",
      tc: "54321",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Favori Doktorlarım',
          style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: doctors.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: screenHeight * 0.015),
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DoctorBilgiEkran(doctorId: doctor.tc ?? ""),
                        ),
                      );
                    },
                    child: DoctorCard(
                      name: doctor.name ?? "",
                      specialization: doctor.branch ?? "",
                      rating: "", // Derecelendirme bilgisi eklenebilir.
                      reviews: doctor.reviews?.length.toString() ?? "0",
                      favourite: true,
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


class DoctorBilgiEkran extends StatelessWidget {
  final String doctorId;

  DoctorBilgiEkran({required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doktor Bilgi Ekranı"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Text("Doktor ID: $doctorId"),
      ),
    );
  }
}


