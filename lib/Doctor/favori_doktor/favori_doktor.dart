import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/doktor_bilgi/doktor_bilgi.dart';
import 'package:yazilim_projesi/Doctor/favori_doktor/favoriDoktor_fonks.dart';
import 'package:yazilim_projesi/Hasta/ana_ekran/anaekranfonk.dart';
import 'package:yazilim_projesi/models/Doctors.dart';

class FavoriteDoctorsPage extends StatefulWidget {
  const FavoriteDoctorsPage({super.key});

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

  Future<void> _loadData() async {
    try {
      final fetchedDoctors = await fonks.fetchFavDoctors();
      setState(() {
        doctors = fetchedDoctors;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Favori Doktorlar Görüntülenemedi")),
      );
      print("Error loading data: $e");
    }
  }

  Future<void> _removeFavorite(Doctors doctor) async {
    try {
      print('Favori doktor silme işlemi başladı. Doktor: ${doctor.tc}');
      await fonks.removeFavorite(doctor);
      setState(() {
        doctors!.remove(doctor);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doktor favorilerden kaldırıldı.")),
      );
    } catch (e) {
      print('Favori doktor silme işlemi başarısız oldu. Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hata: Doktor favorilerden kaldırılamadı.")),
      );
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
                          rating: doctor.avgPoint.toString(),
                          favourite: true,
                          onFavoriteTap: () {
                            _removeFavorite(doctor);
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
