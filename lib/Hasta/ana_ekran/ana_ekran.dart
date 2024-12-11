import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yazilim_projesi/Hasta/HastaProfil/hasta_profil.dart';
import 'package:yazilim_projesi/Hasta/gecmisRandevu/gecmis_randevu.dart';
import 'package:yazilim_projesi/Hasta/yaklasan_randevular/yaklasan_randevular.dart';
import 'package:yazilim_projesi/giris_ekran/giris_ekrani.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';
import 'anaekranfonk.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

Future<void> ara(String aramaKelimesi) async {
  print("Aramaya Basıldı ");
}

class _AnaEkranState extends State<AnaEkran> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Doctors> doctors = [];

  void _loadData() async {
    const String jsonFile = 'assets/MockData/doctors.json';
    final dataString = await rootBundle.loadString(jsonFile);
    final List<dynamic> dataJson = jsonDecode(dataString);

    doctors = dataJson.map((json) => Doctors.fromJson(json)).toList();

    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarını al
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Dinamik boyutlar için ayar
    double fontSize = screenWidth * 0.05;
    double paddingValue = screenWidth * 0.04;
    double avatarRadius = screenWidth * 0.1;
    double buttonPadding = screenWidth * 0.05;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: beyaz,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: acikKirmizi,
              ),
              child: Text(
                'Sağlıklı Günler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Geçmiş Randevular'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  GecmisRandevular()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profilim'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HastaProfil()));
              },
            ),
            const Divider(), // Görsel ayrım için çizgi
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Çıkış Yap',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GirisEkrani()));
                // Çıkış işlemleri
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 50.0, right: 16.0, left: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Selam Kaan ',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: "ABeeZee",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                  child: Image.asset(
                    'resimler/menu.png',
                    width: screenWidth * 0.08,
                    height: screenHeight * 0.08,
                  ),
                ),
              ],
            ),
            Text(
              "Sağlıklı Günler",
              style: TextStyle(
                fontSize: fontSize * 0.8,
                fontFamily: "PtSans",
                color: gri,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: acikKirmizi,
                foregroundColor: beyaz,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: buttonPadding,
                  vertical: screenHeight * 0.015,
                ),
              ),
              child: const Text(
                "Randevu Al",
                style: TextStyle(fontFamily: "ABeeZee"),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Yaklaşan Randevular",
                  style: TextStyle(
                    fontFamily: "ABeeZee",
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => YaklasanRandevular()));
                  },

                  child: Text(
                    " Görüntüle",
                    style: TextStyle(
                      fontFamily: "ABeeZee",
                      fontWeight: FontWeight.normal,
                      fontSize: fontSize * 0.6,
                      color: acikKirmizi,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            InkWell(
              onTap: () {
                print('Schedule tıklandı');
              },
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: beyaz,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: acikGri.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: const NetworkImage(
                        'https://media.istockphoto.com/id/1190555653/tr/vekt%C3%B6r/t%C4%B1p-doktoru-profil-simgesi-erkek-doktor-avatar-vekt%C3%B6r-ill%C3%BCstrasyon.jpg?s=170667a&w=0&k=20&c=Jq7BljB3HJND48e8t_JHgRilKtZBr39UZqXeh_SeCYg=',
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prof. Dr. Mehmet Eriş',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "PtSans",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Üroloji',
                          style: TextStyle(
                              fontSize: 15, fontFamily: "PtSans", color: gri),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Image.asset(
                              'resimler/calendar.png',
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Text(
                              'June 12, 9:30 AM',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "PtSans",
                                  color: gri),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Popüler Doktorlar',
              style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: ListView.separated(
                itemCount: doctors.length,
                separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.015),
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorCard(
                    name: doctor.Doctor_name,
                    specialization: doctor.branch ?? "",
                    rating: "",
                    reviews: doctor.reviews?.length.toString() ?? "0",
                    favourite: true,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
