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
    // Getting screen size and width for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjusting font size and padding based on screen width
    double fontSize = screenWidth * 0.05; // 5% of screen width for font size
    double paddingValue = screenWidth * 0.04; // 4% of screen width for padding
    double avatarRadius = screenWidth * 0.1; // Circle Avatar radius based on width
    double buttonPadding = screenWidth * 0.05; // Padding for button

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
                  fontSize: fontSize, // Adjust font size
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
                Text(
                  'Selam Kaan ',
                  style: TextStyle(
                    fontSize: fontSize, // Dynamic font size
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
                    width: screenWidth * 0.08, // Width for the menu icon
                    height: screenHeight * 0.08, // Height for the menu icon
                  ),
                ),
              ],
            ),
            Text(
              "Sağlıklı Günler",
              style: TextStyle(
                fontSize: fontSize * 0.8, // Slightly smaller font size
                fontFamily: "PtSans",
                color: gri,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Spacing for elements
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: acikKirmizi,
                foregroundColor: beyaz,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.05), // Dynamic border radius
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: buttonPadding,
                  vertical: screenHeight * 0.015, // Vertical padding
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                "Randevu Al",
                style: TextStyle(fontFamily: "ABeeZee"),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            const Text(
              'Yaklaşan Randevular ',
              style: TextStyle(
                fontSize: 22,
                fontFamily: "ABeeZee",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            InkWell(
              onTap: () {
                print('Schedule tıklandı');
              },
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.04), // Dynamic padding
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
                      radius: avatarRadius, // Dynamic avatar radius
                      backgroundImage: NetworkImage(
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
                        SizedBox(height: screenHeight * 0.02), // Vertical spacing
                        Row(
                          children: [
                            Image.asset(
                              'resimler/calendar.png',
                              width: screenWidth * 0.05, // Icon width
                              height: screenWidth * 0.05, // Icon height
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
            const Text(
              'Popüler Doktorlar',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),
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
