import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/favori_doktor/favoriDoktor_fonks.dart';
import 'package:yazilim_projesi/models/Doctors.dart';

class FavoriteDoctorsPage extends StatefulWidget {
  const FavoriteDoctorsPage({Key? key}) : super(key: key);

  @override
  _FavoriteDoctorsPageState createState() => _FavoriteDoctorsPageState();
}

class _FavoriteDoctorsPageState extends State<FavoriteDoctorsPage> {
  final FavoriDoktorFonks fonks = FavoriDoktorFonks();

  List<Doctors>? doctors;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final fetchedDoctors = await fonks.fetchFavDoctors();
      setState(() {
        doctors = fetchedDoctors;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

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
        child: doctors == null
            ? const Center(child: CircularProgressIndicator())
            : doctors!.isEmpty
                ? const Center(
                    child: Text(
                      "Favori doktor bulunamadı.",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                : ListView.separated(
                    itemCount: doctors!.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: screenHeight * 0.015),
                    itemBuilder: (context, index) {
                      final doctor = doctors![index];
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
    );
  }
}

class DoctorBilgiEkran extends StatelessWidget {
  final String doctorId;

  const DoctorBilgiEkran({Key? key, required this.doctorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doktor Bilgi Ekranı"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Text("Doktor ID: $doctorId"),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String rating;
  final String reviews;
  final bool favourite;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.reviews,
    required this.favourite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(specialization),
            Text("Reviews: $reviews"),
          ],
        ),
        trailing: favourite ? const Icon(Icons.favorite, color: Colors.red) : null,
      ),
    );
  }
}
