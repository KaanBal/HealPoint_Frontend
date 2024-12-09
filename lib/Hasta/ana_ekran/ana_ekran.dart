import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child: const Text(
                'Sağlıklı Günler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Geçmiş Randevular'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profilim'),
              onTap: () {
                Navigator.pop(context);
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
                const Text(
                  'Selam Kaan ',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "ABeeZee",
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                  child: Image.asset(
                    'resimler/menu.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            Text(
              "Sağlıklı Günler",
              style: TextStyle(fontSize: 17, fontFamily: "PtSans", color: gri),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: acikKirmizi,
                foregroundColor: beyaz,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                "Randevu Al",
                style: TextStyle(fontFamily: "ABeeZee"),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Yaklaşan Randevular ',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                print('Schedule tıklandı');
              },
              child: Container(
                padding: const EdgeInsets.all(16),
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
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/1190555653/tr/vekt%C3%B6r/t%C4%B1p-doktoru-profil-simgesi-erkek-doktor-avatar-vekt%C3%B6r-ill%C3%BCstrasyon.jpg?s=170667a&w=0&k=20&c=Jq7BljB3HJND48e8t_JHgRilKtZBr39UZqXeh_SeCYg=',
                      ),
                    ),
                    const SizedBox(width: 15),
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
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset(
                              'resimler/calendar.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
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
            const SizedBox(height: 30),
            const Text(
              'Popüler Doktorlar',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
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
