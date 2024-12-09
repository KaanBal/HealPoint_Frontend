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
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: beyaz,
        appBar: AppBar(
          backgroundColor: acikKirmizi,
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
          toolbarHeight: 275,
          title: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Column(
              children: [
                profilePhotos(),
                profileName(),
                branch(),
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
                  contactDetail(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding branch() {
    return const Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Text(
        "Ürolog",
        style: TextStyle(
          fontFamily: "ABeeZee",
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      ),
    );
  }

  Padding profileName() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          "Dr. William Anderson",
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container profilePhotos() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      width: 105,
      height: 105,
      alignment: Alignment.center,
      child: const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('resimler/doktor.png'),
      ),
    );
  }

  Widget contactDetail() {
    return Card(
      margin: const EdgeInsets.all(20),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTile("Şehir", city, Icons.location_city),
            buildTile("İlçe", district, Icons.my_location),
            buildTile("Adres", address, Icons.location_pin),
            buildTile("Telefon No", phone, Icons.phone_android),
            buildTile("Email", email, Icons.mail),
          ],
        ),
      ),
    );
  }

  ListTile buildTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(color: Colors.black),
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
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
