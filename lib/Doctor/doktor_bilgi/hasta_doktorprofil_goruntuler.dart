import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class HastaDoktorprofilGoruntuler extends StatefulWidget {
  const HastaDoktorprofilGoruntuler({super.key});

  @override
  State<HastaDoktorprofilGoruntuler> createState() =>
      _HastaDoktorprofilGoruntulerState();
}

class _HastaDoktorprofilGoruntulerState
    extends State<HastaDoktorprofilGoruntuler> {
  final String city = "Adana";
  final String district = "Sarıçam";
  final String address = "156.sokak ahmetağa mah.";
  final String phone = "***********";
  final String email = "********@gmail.com";

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarına göre ölçekleme faktörü
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Font boyutları için ölçek faktörü (bu faktörü daha da küçültebilirsiniz)
    double fontScaleFactor = 0.9;

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: beyaz,
        appBar: AppBar(
          backgroundColor: acikKirmizi,
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
          toolbarHeight: screenHeight * 0.35, // App bar yüksekliğini dinamik yapıyoruz
          title: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05),
            child: Column(
              children: [
                profilePhotos(screenWidth),
                profileName(fontScaleFactor),
                branch(fontScaleFactor),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            indicatorColor: siyah,
            labelColor: beyaz,
            unselectedLabelColor: beyaz,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                text: "Bilgiler",
                icon: Icon(Icons.contact_page),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  contactDetail(screenWidth, fontScaleFactor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding branch(double fontScaleFactor) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Text(
        "Ürolog",
        style: TextStyle(
          fontFamily: "ABeeZee",
          fontWeight: FontWeight.normal,
          fontSize: MediaQuery.of(context).size.width * 0.04 * fontScaleFactor, // Dinamik font boyutu
        ),
      ),
    );
  }

  Padding profileName(double fontScaleFactor) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          "Dr. William Anderson",
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize: MediaQuery.of(context).size.width * 0.045 * fontScaleFactor, // Dinamik font boyutu
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container profilePhotos(double screenWidth) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      width: screenWidth * 0.3, // Ekran genişliğine göre dinamik boyutlandırma
      height: screenWidth * 0.3, // Ekran genişliğine göre dinamik boyutlandırma
      alignment: Alignment.center,
      child: const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('resimler/doktor.png'),
      ),
    );
  }

  Widget contactDetail(double screenWidth, double fontScaleFactor) {
    return Card(
      margin: EdgeInsets.all(screenWidth * 0.05), // Dinamik margin
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTile("Şehir", city, Icons.location_city, fontScaleFactor),
            buildTile("İlçe", district, Icons.my_location, fontScaleFactor),
            buildTile("Adres", address, Icons.location_pin, fontScaleFactor),
            buildTile("Telefon No", phone, Icons.phone_android, fontScaleFactor),
            buildTile("Email", email, Icons.mail, fontScaleFactor),
          ],
        ),
      ),
    );
  }

  ListTile buildTile(String title, String value, IconData icon, double fontScaleFactor) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.04 * fontScaleFactor, // Dinamik font boyutu
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.035 * fontScaleFactor, // Dinamik font boyutu
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final String aboutText;

  const AboutSection({super.key, required this.aboutText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Card(
            margin: const EdgeInsets.all(20),
            color: beyaz,
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Text(
                aboutText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.04, // Dinamik font boyutu
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
